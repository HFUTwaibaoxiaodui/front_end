import 'package:flutter/material.dart';
import 'package:frontend/util/debug_print.dart';
import '../global/state_label_colors.dart';
import 'order.dart';

class OrderDetail extends StatefulWidget {

  Order order;
  final double detailFontSize = 14;

  OrderDetail(this.order, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OrderDetailState();

  String _creatorLine() {
    if (order.creatorName == null || order.phoneNum == null) {
      return 'null';
    } else {
      return order.creatorName! + '    ' + order.phoneNum!;
    }
  }

  Widget buildTop() {
    return Container(
      // width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(order.orderCode ?? 'null', style: TextStyle(color: Colors.grey.shade800, fontSize: detailFontSize)),
            trailing: RawChip(
              label: Text(order.orderState),
              backgroundColor: labelColorMap[order.orderState]!,
              labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Divider(thickness: 0.5, color: Colors.grey.shade300),
          ListTile(
            title: Text(order.orderTitle ?? 'null', style: const TextStyle(fontSize: 18)),
          ),
          ListTile(
            title: Text(_creatorLine(), style: TextStyle(color: Colors.grey, fontSize: detailFontSize)),
            trailing: const Icon(Icons.phone, color: Colors.blue)
          ),
          ListTile(
            title: Text(
                  order.orderAddress ?? 'null',
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

}

class OrderDetailState extends State<OrderDetail> with SingleTickerProviderStateMixin{

  final List<String> _tabValues = [
    '工单属性',
    '处理过程',
    '回单信息',
  ];

  final List<Widget> _pages = [];

  int _currentIndex = 0;
  late TabController tabController;
  late PageController pageController;

  @override
  void initState() {
    tabController = TabController(length: _tabValues.length, vsync: this, initialIndex: 0);
    pageController = PageController(initialPage: _currentIndex);
    _pages.add(_buildOrderAttributes());
    _pages.add(Container(color: Colors.red));
    _pages.add(Container(color: Colors.green));
  }

  Widget _buildPopUpList() {
    return PopupMenuButton<String>(
        itemBuilder: (context) => <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: '语文',
            child: GestureDetector(

            ),
          ),
        ]
    );
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
        ListTile(title: const Text('工单创建人'), subtitle: Text(widget.order.creatorName ?? 'null')),
        ListTile(title: const Text('创建练习电话'), subtitle: Text(widget.order.phoneNum ?? 'null')),
        ListTile(title: const Text('工单详细地址'), subtitle: Text(widget.order.orderAddress ?? 'null')),
        ListTile(title: const Text('工单创建时间'), subtitle: Text(widget.order.createTime ?? 'null')),
        ListTile(title: const Text('工单创建时间'), subtitle: Text(widget.order.createTime ?? 'null')),
        ListTile(title: const Text('工单创建时间'), subtitle: Text(widget.order.createTime ?? 'null')),
        ListTile(title: const Text('工单创建时间'), subtitle: Text(widget.order.createTime ?? 'null')),
      ],
    );
  }

  Widget _buildBottom() {
    switch(widget.order.orderState) {
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
                onTap: (){
                  setState(() {
                    widget.order.orderState = '服务中';
                  });
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
                  printWithDebug('填写回单');
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
                widget.order.orderState = '待服务';
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
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工单详情', style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent.shade700,
        // 底部阴影
        elevation: 0.5,
        actions:[_buildPopUpList()],
      ),
      body:  Container (
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
                    margin: const EdgeInsets.only(bottom: 10),
                    child: widget.buildTop(),
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
      )
    );
  }
}