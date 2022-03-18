import 'dart:async';
import 'dart:typed_data';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/exception_handle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:frontend/util/debug_print.dart';
import '../global/back_end_interface_url.dart';
import '../global/my_event_bus.dart';
import '../global/state_label_colors.dart';
import '../views/edit_work_order.dart';
import 'order_list.dart';
import '../models/operation.dart';
import '../pages/exception_report.dart';
import '../util/net/network_util.dart';
import '../models/order.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/util/qrcode_util.dart';

class OrderDetail extends StatefulWidget {

  int id;

  OrderDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetail> with SingleTickerProviderStateMixin{

  final List<String> _tabValues = [
    '工单属性',
    '处理过程',
    '回单信息',
  ];

  final List<Widget> _pages = [];
  Uint8List? _qrcodeBytes;

  final double detailFontSize = 14;

  int _currentIndex = 0;
  late TabController tabController;
  late PageController pageController;
  Order? _order;
  bool _isLoading = false;

  late final PopupMenuItem<String> reassignment;
  late final PopupMenuItem<String> exception;

  StateSetter? _orderOperationSetter;
  late StreamSubscription _refreshSubscription;

  @override
  void initState() {
    super.initState();
    _loadData();
    tabController = TabController(length: _tabValues.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: _currentIndex);

    _refreshSubscription = eventBus.on<RefreshOrderDetailEvent>().listen((event) {
      _refresh();
    });

    reassignment = PopupMenuItem<String>(
      value: '转派工单',
      child: GestureDetector(
        onTap: () {
          printWithDebug('转派工单');
        },
        child: const Text('转派工单'),
      ),
    );
    exception = PopupMenuItem<String>(
      value: '异常上报',
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ExceptionReport(id: widget.id);
          }
          ));
        },
        child: const Text('异常上报'),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    pageController.dispose();
    _refreshSubscription.cancel();
    super.dispose();
  }

  void _loadData() {
    _getOrder().then((value){
      setState(() {
        _order = value;
      });
    });

    // QRCodeUtil.generateQRCode(_order == null ? 'null' : _order!.orderAddress!).then((value){
    //   setState(() {
    //     _qrcodeBytes = value;
    //   });
    // });
  }

  void _refresh() {
    printWithDebug('开始refresh');
    _loadData();
    printWithDebug('结束refresh');
  }

  Future<Order> _getOrder() async {
    Map<String, dynamic> gotOrder = await HttpManager().get(getOrderById, args: {'orderId': widget.id});
    return Order.fromJson(gotOrder);
  }

  String _creatorLine() {
    if (_order!.creatorName == null || _order!.phoneNum == null) {
      return 'null';
    } else {
      return _order!.creatorName! + '    ' + _order!.phoneNum!;
    }
  }

  Widget _buildTop() {
    return Container(
      // width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(_order!.orderCode ?? 'null', style: TextStyle(color: Colors.grey.shade800, fontSize: detailFontSize)),
            trailing: RawChip(
              label: Text(_order!.orderState),
              backgroundColor: labelColorMap[_order!.orderState]!,
              labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Divider(thickness: 0.5, color: Colors.grey.shade300),
          ListTile(
            title: Text(_order!.orderTitle ?? 'null', style: const TextStyle(fontSize: 18)),
          ),
          ListTile(
              title: Text(_creatorLine(), style: TextStyle(color: Colors.grey, fontSize: detailFontSize)),
              trailing: GestureDetector(
                onTap: () async {
                    String url = 'tel:'+ _order!.phoneNum!;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      Fluttertoast.showToast(
                          msg: "拨号失败",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                },
                child: const Icon(Icons.phone, color: Colors.blue)
              )
          ),
          ListTile(
            title: Text(
                _order!.orderAddress ?? 'null',
                maxLines: 2,
                style: const TextStyle (
                    color: Colors.grey,
                    overflow: TextOverflow.ellipsis,
                    fontSize: 12
                )
            ),
            trailing: const Icon(Icons.where_to_vote, color: Colors.blue),
          ),
        ],
      ),
    );
  }

  Widget _buildPopUpList() {
    switch (_order!.orderState) {
      case '待服务':
        return PopupMenuButton<String>(
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            reassignment
          ],
        );
      case '服务中':
        return PopupMenuButton<String>(
          itemBuilder: (context) => <PopupMenuEntry<String>>[
            reassignment,
            exception
          ]
        );
    }
    return Container();
  }

  Widget _buildMiddle() {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              TabBar(
                // 控制器
                controller: tabController,
                // 选中时文字颜色
                labelColor: Colors.cyanAccent.shade700,
                // 默认文字颜色
                unselectedLabelColor: Colors.black,
                // 创建item
                tabs: _tabValues.map( (v) => Tab(text: v) ).toList(),
                // 线条指示器颜色
                indicatorColor: Colors.cyanAccent.shade700,
                // 线条宽度
                // TabBarIndicatorSize.label 根据内容调整宽度
                // TabBarIndicatorSize.tab 根据(mainWidth/itemCount)调整宽度
                indicatorSize: TabBarIndicatorSize.tab,
                // 点击item
                onTap: (int index){
                  _currentIndex = index;
                  // 切换到指定索引
                  // curve 动画过度样式
                  pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear);
                },
              ),
            ],
          )
        ),
        Expanded(
          flex: 5,
          child: PageView(
            children: _pages,
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
          )
        )
      ],
    );
  }

  Widget _buildOrderAttributes() {
    return ListView(
      children: [
        ListTile(title: const Text('工单创建人'), subtitle: Text(_order!.creatorName ?? 'null')),
        ListTile(title: const Text('创建练习电话'), subtitle: Text(_order!.phoneNum ?? 'null')),
        ListTile(title: const Text('工单详细地址'), subtitle: Text(_order!.orderAddress ?? 'null')),
        ListTile(title: const Text('工单创建时间'), subtitle: Text(_order!.createTime ?? 'null')),
        ListTile(title: const Text('工单创建时间'), subtitle: Text(_order!.createTime ?? 'null')),
        ListTile(title: const Text('工单创建时间'), subtitle: Text(_order!.createTime ?? 'null')),
        ListTile(title: const Text('工单创建时间'), subtitle: Text(_order!.createTime ?? 'null')),
        // Container(height: 200, decoration: BoxDecoration(image: DecorationImage(image: MemoryImage(_qrcodeBytes!)))),
      ],
    );
  }

  void _initTabState() {
    setState(() {
      _currentIndex = 0;
    });
  }

  Widget _buildOperationProgress() {
    return  StatefulBuilder( builder: (BuildContext context, StateSetter stateSetter) {
      _orderOperationSetter = stateSetter;

      Widget redDivider = const Divider(color: Colors.red);
      Widget blueDivider = const Divider(color: Colors.blue);
      List<Operation>? list = _order!.operationList;

      return ListView.separated(
        itemCount: list == null ? 0 : list.length,
        separatorBuilder: (BuildContext context, int index){
          return index % 2 == 0 ? redDivider:blueDivider;
        },
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(list![index].operationName ?? 'null'),
            subtitle: Text(list[index].description ?? 'null'),
            trailing: Text(list[index].operationTime ?? 'null'),
          );
        },
      );
    });
  }

  Widget _buildBottom() {
    switch(_order!.orderState) {
      // case '待服务': return Container(
      //   padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      //   child: Padding(
      //     padding: const EdgeInsets.all(5),
      //     child: Row(
      //         children: [
      //           Expanded(
      //             flex: 1,
      //             child: Container(
      //               color: Colors.white,
      //               child: const Center(
      //                 child: Text('扫码签到'),
      //               ),
      //             )
      //           ),
      //           const SizedBox(width: 10),
      //           Expanded(
      //               flex: 1,
      //               child: Container(
      //                 color: Colors.cyanAccent.shade700,
      //                 child: const Center(
      //                   child: Text('开始巡检', style: TextStyle(color: Colors.white)),
      //                 ),
      //               )
      //           ),
      //         ],
      //       ),
      //   )
      // );
      case '待服务': return Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: () async {
                  /// 进行扫码验证
                  printWithDebug('扫码验证');

                  String? qrCode = await QRCodeUtil.scanCamera();
                  if (qrCode != _order!.orderAddress) {
                    printWithDebug('验证成功');
                    /// 状态由待抢单转为待服务
                    HttpManager().put(updateOrderState, args: {'orderId': widget.id, 'orderState': '服务中'});
                    String formattedDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss]);
                    HttpManager().post(
                        addOperationLog,
                        args: {
                          'orderId': _order!.id,
                          'operationTime': formattedDate,
                          'operationName': '开始服务',
                          'description': '【我】已开始服务'
                        }
                    ).then((value) {
                      Fluttertoast.showToast(
                          msg: "验证成功，开始巡检",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                      _refresh();
                      eventBus.fire(InitOrderListEvent());
                    });
                  } else {
                    printWithDebug('验证失败');
                    /// 提示用户抢单成功
                    Fluttertoast.showToast(
                        msg: "验证失败",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                child: Container(
                  color: Colors.cyanAccent.shade700,
                  child: const Center(
                    child: Text('扫码签到', style: TextStyle(color: Colors.white)
                    ),
                  ),
                ),
              )
          )
      );
      case '服务中': return Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                    return EditOrder(id: widget.id);
                  }));
                },
                child: Container(
                  color: Colors.cyanAccent.shade700,
                  child: const Center(
                    child: Text('填写回单', style: TextStyle(color: Colors.white)
                    ),
                  ),
                ),
              )
          )
      );
      case '待抢单': return Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: GestureDetector(
            onTap: (){
              setState(() {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('提示'),
                        content: const Text('确认接单吗？'),
                        actions: <Widget>[
                          TextButton(child: const Text('取消'),onPressed: (){
                            printWithDebug('已取消接单');
                            Navigator.of(context).pop();
                          }),
                          TextButton(child: const Text('确认'),onPressed: () {
                            HttpManager().put(updateOrderState, args: {'orderId': widget.id, 'orderState': '待服务'});
                            String formattedDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss]);
                            HttpManager().post(
                                addOperationLog,
                                args: {
                                  'orderId': _order!.id,
                                  'operationTime': formattedDate,
                                  'operationName': '抢单',
                                  'description': '【我】已抢得【' + _order!.creatorName! + '】创建的工单'
                                }
                            ).then((value){
                              /// 提示用户抢单成功
                              Fluttertoast.showToast(
                                  msg: "抢单成功",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                              _initTabState();
                              _refresh();
                              eventBus.fire(InitOrderListEvent());
                              /// 返回上一个界面
                              Navigator.of(context).pop();
                            });
                          },),
                        ],
                      );
                    });
              });
            },
            child: Container(
              color: Colors.cyanAccent.shade700,
              child: const Center(
                child: Text('我要抢单', style: TextStyle(color: Colors.white)
                ),
              ),
            ),
          )
        )
      );
      case '异常': return Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return ExceptionHandle();
                  }));
                },
                child: Container(
                  color: Colors.cyanAccent.shade700,
                  child: const Center(
                    child: Text('处理异常', style: TextStyle(color: Colors.white)
                    ),
                  ),
                ),
              )
          )
      );
      case '待评价': return Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pushNamed('/order_evaluate', arguments: {'id': widget.id, 'name': _order!.creatorName!});
                },
                child: Container(
                  color: Colors.cyanAccent.shade700,
                  child: const Center(
                    child: Text('评价工单', style: TextStyle(color: Colors.white)
                    ),
                  ),
                ),
              )
          )
      );
      case '已完成': return Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: GestureDetector(
                onTap: (){
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {

                        return AlertDialog(
                          title: const Text('工单评价'),
                          content: Container(
                            height: MediaQuery.of(context).size.height * 0.23,
                            child:  Column(
                              children: [

                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(child: const Text('取消'),onPressed: (){
                              Navigator.of(context).pop();
                            }),
                          ],
                        );
                      }
                  );
                },
                child: Container(
                  color: Colors.cyanAccent.shade700,
                  child: const Center(
                    child: Text('查看评价', style: TextStyle(color: Colors.white)
                    ),
                  ),
                ),
              )
          )
      );
    }

    return Container();
  }

  Widget _buildOrderDetail() {
    print(' 当前order  ' + _order!.toString());
    _pages.add(_buildOrderAttributes());
    _pages.add(_buildOperationProgress());
    _pages.add(Container(color: Colors.green));

    return Container (
      // height: MediaQuery.of(context).size.height,
      // width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade300,
        // margin: EdgeInsets.all(5),
        child: Container(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 2),
                  child: _buildTop(),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  color: Colors.white,
                  child: _buildMiddle(),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  child: _buildBottom(),
                ),
              ),
            ],
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    printWithDebug('触发build');

    _isLoading = (_order == null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('工单详情', style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent.shade700,
        // 底部阴影
        elevation: 0.5,
        actions:[
          _isLoading ? Container(): _buildPopUpList()
        ],
      ),
        body: _isLoading ? _buildLoadingContent() : _buildOrderDetail()
      );
  }

  Widget _buildLoadingContent() {
    return Center(
          child: CircularProgressIndicator( // 加载指示器
            valueColor: AlwaysStoppedAnimation<Color>(Colors.cyanAccent.shade700), // 设置指示器颜色
            backgroundColor: Colors.white,  // 设置背景色
          ),
        );
  }
}