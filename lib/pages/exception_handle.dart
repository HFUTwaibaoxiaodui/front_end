import 'dart:async';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/global/my_event_bus.dart';
import 'package:frontend/util/debug_print.dart';
import 'package:frontend/util/net/network_util.dart';
import 'package:provider/provider.dart';
import '../global/back_end_interface_url.dart';
import '../global/user_info.dart';
import '../widgets/order_list.dart';


class ExceptionHandle extends StatefulWidget {

  int orderId;
  int workerId;

  ExceptionHandle({
    Key? key,
    required this.orderId,
    required this.workerId,

  }) : super(key: key);

  @override
  State<StatefulWidget> createState()  => ExceptionHandleState();
}

class ExceptionHandleState extends State<ExceptionHandle> {

  late TextEditingController _handleOption;
  late TextEditingController _handleDetail;
  late FocusNode _focusNode;
  String _selecting = "";
  String? _exceptionClass;
  String? _exceptionDescription;
  String? _lastOrderState;
  late StreamSubscription _updateExceptionHandlePage;

  @override
  void initState() {
    super.initState();
    _loadExceptionMessage();
    _updateExceptionHandlePage = eventBus.on<UpdateExceptionHandlePage>().listen((event) {
      setState(() {});
    });
    _handleOption = TextEditingController();
    _handleDetail = TextEditingController();
    _focusNode = FocusNode();
    _handleOption.text = "";
  }

  @override
  void dispose() {
    _updateExceptionHandlePage.cancel();
    _handleOption.dispose();
    _handleDetail.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _loadExceptionMessage() {
    HttpManager().get(
      getExceptionMessageById,
      args: {
        'orderId': widget.orderId
      }
    ).then((value){
       setState(() {
         _lastOrderState = value['lastOrderState'];
         _exceptionClass = value['exceptionClass'];
         _exceptionDescription = value['exceptionDetail'];
       });
    });
  }

  Widget _buildBottom() {
    switch (_handleOption.text) {
      case '驳回请求':
        return Column(
          children: [
            Divider(thickness: 0.5, color: Colors.grey.shade400),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: ListTile(title: Text('驳回原因')),flex: 2),
                Expanded(child: ListTile(
                  contentPadding: const EdgeInsets.only(top: 14),
                  title: TextField(
                    focusNode: _focusNode,
                    controller: _handleDetail,
                    decoration: const InputDecoration.collapsed(
                      hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                      hintText: "驳回原因",
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                    maxLength: 300,
                  ),
                ),flex: 3),
                Expanded(child: Container(),flex: 1),
              ],
            )
          ],
        );
      case '取消工单':
        return Column(
          children: [
            Divider(thickness: 0.5, color: Colors.grey.shade400),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: ListTile(title: Text('取消原因')),flex: 2),
                Expanded(child: ListTile(
                  contentPadding: const EdgeInsets.only(top: 14),
                  title: TextField(
                    focusNode: _focusNode,
                    controller: _handleDetail,
                    decoration: const InputDecoration.collapsed(
                      hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                      hintText: "取消原因",
                      border: InputBorder.none,
                    ),
                    maxLines: 5,
                    maxLength: 300,
                  ),
                ),flex: 3),
                Expanded(child: Container(),flex: 1),
              ],
            )
          ],
        );
      case '重新分配':
        return Column(
          children: [
            Divider(thickness: 0.5, color: Colors.grey.shade400),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(child: ListTile(title: Text('巡检员')),flex: 4),
                Expanded(child: ListTile(
                  title: TextField(
                    controller: _handleDetail,
                    enabled: false,
                    decoration: const InputDecoration.collapsed(
                      hintText: "请选择巡检员（必填）",
                      border: InputBorder.none,
                    ),
                  ),
                ),flex: 8),
                const Expanded(child: ListTile(
                  title: Icon(Icons.keyboard_arrow_right),
                ),flex: 3),
              ],
            )
          ],
        );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('异常处理', style: TextStyle(color: Colors.white, fontSize: 20)),
          centerTitle: true,
          backgroundColor: Colors.cyanAccent.shade700,
          // 底部阴影
          elevation: 0.5,
        ),
      body: GestureDetector(
        onTap: (){ _focusNode.unfocus(); },
        child: Builder(
          builder: (context) {
            return Container(
              color: Colors.grey.shade300,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        ListTile(title: const Text('异常类型'), subtitle: Text(_exceptionClass ?? 'null')),
                        ListTile(title: const Text('异常描述'), subtitle: Text(_exceptionDescription ?? 'null')),
                        Row(
                          children: [
                            const Expanded(child: ListTile(title: Text('处理方式')),flex: 2),
                            Expanded(child: TextField(
                              controller: _handleOption,
                              enabled: false,
                              decoration: const InputDecoration.collapsed(
                                hintText: "请选择处理方式（必填）",
                                border: InputBorder.none,
                              ),
                            ),flex: 3),
                            Expanded(child: ListTile(
                              title: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (BuildContext context, void Function(void Function()) setState) {
                                          return AlertDialog(
                                            title: const Text('处理方式'),
                                            content: Container(
                                              height: MediaQuery.of(context).size.height * 0.23,
                                              child:  Column(
                                                children: [
                                                  RadioListTile<String>(
                                                      value: "驳回请求",
                                                      title: const Text("驳回请求"),
                                                      groupValue: _selecting,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selecting = value!;
                                                        });
                                                      }
                                                  ),
                                                  RadioListTile<String>(
                                                      value: "重新分配",
                                                      title: const Text("重新分配"),
                                                      groupValue: _selecting,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selecting = value!;
                                                        });
                                                      }
                                                  ),
                                                  RadioListTile<String>(
                                                      value: "取消工单",
                                                      title: const Text("取消工单"),
                                                      groupValue: _selecting,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _selecting = value!;
                                                        });
                                                      }
                                                  )
                                                ],
                                              ),
                                            ),
                                            actions: <Widget>[
                                              TextButton(child: const Text('取消'),onPressed: (){
                                                Navigator.of(context).pop();
                                              }),
                                              TextButton(child: const Text('确认'),onPressed: (){
                                                _handleOption.text = _selecting;
                                                eventBus.fire(UpdateExceptionHandlePage());
                                                Navigator.of(context).pop();
                                              },),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                );
                              },
                            )
                                ,flex: 1),
                          ],
                        ),
                        _buildBottom()
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: GestureDetector(
                          onTap: () {
                            SnackBar snackBar;
                            if (_handleOption.text == "") {
                              snackBar = const SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.red,
                                content: Text('处理方式不能为空!'),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            } else if (_handleDetail.text == "") {
                              snackBar = const SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.red,
                                content: Text('请填写处理意见!'),
                              );
                              Scaffold.of(context).showSnackBar(snackBar);
                            } else {
                              HttpManager().put(
                                updateExceptionSolveState,
                                args: {
                                  'orderId': widget.orderId
                                }
                              );
                              switch (_handleOption.text) {
                                case "取消工单":
                                  HttpManager().put(updateOrderState, args: {'orderId': widget.orderId, 'orderState': '已取消'});
                                  HttpManager().post(
                                      sendMessage,
                                      args: {
                                        'alias': widget.workerId,
                                        'message': '你有一份异常工单被管理员取消',
                                        'name': Provider.of<UserInfo>(context, listen:false).realName,
                                        'orderId': widget.orderId
                                      }
                                  );
                                  String formattedDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
                                  HttpManager().post(
                                      addOperationLog,
                                      args: {
                                        'orderId': widget.orderId.toString(),
                                        'operationTime': formattedDate,
                                        'operationName': '异常处理',
                                        'description':
                                        '【' + Provider.of<UserInfo>(context, listen: false).realName! + '】取消工单，取消原因：' +
                                            _handleDetail.text
                                      }
                                  ).then((value){
                                    Fluttertoast.showToast(
                                        msg: "已取消工单",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    eventBus.fire(RefreshOrderDetailEvent());
                                    eventBus.fire(InitOrderListEvent());
                                    Navigator.of(context).pop();
                                  });
                                  break;
                                case "驳回请求":
                                  HttpManager().put(updateOrderState, args: {'orderId': widget.orderId, 'orderState': _lastOrderState});
                                  String formattedDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
                                  HttpManager().post(
                                      sendMessage,
                                      args: {
                                        'alias': widget.workerId,
                                        'message': '你的异常请求被驳回',
                                        'name': Provider.of<UserInfo>(context, listen:false).realName,
                                        'orderId': widget.orderId
                                      }
                                  );
                                  HttpManager().post(
                                      addOperationLog,
                                      args: {
                                        'orderId': widget.orderId,
                                        'operationTime': formattedDate,
                                        'operationName': '异常处理',
                                        'description':
                                        '【' + Provider.of<UserInfo>(context, listen: false).realName! + '】驳回请求，驳回原因：' +
                                        _handleDetail.text
                                      }
                                  ).then((value){
                                    Fluttertoast.showToast(
                                        msg: "已驳回异常请求",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        backgroundColor: Colors.blue,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    eventBus.fire(RefreshOrderDetailEvent());
                                    eventBus.fire(InitOrderListEvent());
                                    Navigator.of(context).pop();
                                  });
                                  break;
                                case "重新分配":
                                /// 重新分配 TODO
                                  Navigator.of(context).pop();
                                  break;
                              }
                            }
                          },
                          child: Container(
                            color: Colors.cyanAccent.shade700,
                            child: const Center(
                              child: Text('提交', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)
                              ),
                            ),
                          )
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}