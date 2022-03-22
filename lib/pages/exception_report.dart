import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/global/user_info.dart';
import 'package:frontend/util/debug_print.dart';
import 'package:provider/provider.dart';

import '../global/back_end_interface_url.dart';
import '../global/my_event_bus.dart';
import '../util/net/network_util.dart';


class ExceptionReport extends StatefulWidget {

  int id;
  String lastOrderState;

  ExceptionReport({Key? key, required this.id, required this.lastOrderState}) : super(key: key);

  @override
  State<StatefulWidget> createState()  => ExceptionReportState();
}

class ExceptionReportState extends State<ExceptionReport> {

  late TextEditingController _exceptionClass;
  late TextEditingController _exceptionDetail;
  String _selecting = "";

  @override
  void initState() {
    super.initState();
    _exceptionClass = TextEditingController();
    _exceptionDetail = TextEditingController();
    _exceptionClass.text = "";
  }


  @override
  void dispose() {
    _exceptionClass.dispose();
    _exceptionDetail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('异常上报', style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent.shade700,
        // 底部阴影
        elevation: 0.5,
        ),
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.grey.shade300,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Center(
                    child: Text('异常上报后，工单将由管理员处理', style: TextStyle(color: Colors.grey.shade500)),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          const Expanded(child: ListTile(title: Text('异常上报')),flex: 2),
                          Expanded(child: TextField(
                            controller: _exceptionClass,
                            enabled: false,
                            decoration: const InputDecoration.collapsed(
                              hintText: "请选择异常类别（必填）",
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
                                          title: const Text('异常类别'),
                                          content: Container(
                                            height: MediaQuery.of(context).size.height * 0.23,
                                            child:  Column(
                                              children: [
                                                RadioListTile<String>(
                                                    value: "缺少备件",
                                                    title: const Text("缺少备件"),
                                                    groupValue: _selecting,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selecting = value!;
                                                      });
                                                    }
                                                ),
                                                RadioListTile<String>(
                                                    value: "联系不上客户",
                                                    title: const Text("联系不上客户"),
                                                    groupValue: _selecting,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selecting = value!;
                                                      });
                                                    }
                                                ),
                                                RadioListTile<String>(
                                                    value: "无法维修",
                                                    title: const Text("无法维修"),
                                                    groupValue: _selecting,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selecting = value!;
                                                      });
                                                    }
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(child: const Text('取消'),onPressed: (){
                                              Navigator.of(context).pop();
                                            }),
                                            TextButton(child: const Text('确认'),onPressed: (){
                                              _exceptionClass.text = _selecting;
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
                      Divider(thickness: 0.5, color: Colors.grey.shade400),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(child: ListTile(title: Text('异常说明')),flex: 2),
                          Expanded(child: ListTile(
                            contentPadding: const EdgeInsets.only(top: 14),
                            title: TextField(
                              controller: _exceptionDetail,
                              decoration: const InputDecoration.collapsed(
                                hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                                hintText: "请填写异常说明",
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
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: GestureDetector(
                        onTap: () {
                          SnackBar snackBar;
                          if (_exceptionClass.text == "") {
                            snackBar = const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.red,
                              content: Text('异常类别不能为空!'),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else if (_exceptionDetail.text == "") {
                            snackBar = const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.red,
                              content: Text('请填写上报原因!'),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else {
                            HttpManager().put(updateOrderState, args: {'orderId': widget.id, 'orderState': '异常'});
                            String formattedDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss]);
                            HttpManager().post(submitException,
                                args: {
                                  'exceptionClass': _exceptionClass.text,
                                  'exceptionDetail': _exceptionDetail.text,
                                  'orderId': widget.id,
                                  'submitTime': formattedDate,
                                  'lastOrderState': widget.lastOrderState
                                }
                            );
                            HttpManager().post(
                                addOperationLog,
                                args: {
                                  'orderId': widget.id,
                                  'operationTime': formattedDate,
                                  'operationName': '上报异常',
                                  'description':
                                      '【' + Provider.of<UserInfo>(context, listen: false).realName! + '】'
                                      '上报异常，异常类别：' +
                                      _exceptionClass.text +
                                          "，异常说明：" +
                                          _exceptionDetail.text
                                }
                            ).then((value) {
                              Fluttertoast.showToast(
                                  msg: "异常上报成功",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );

                              eventBus.fire(RefreshOrderDetailEvent());
                              eventBus.fire(InitOrderListEvent());

                              printWithDebug('已发送页面刷新');

                              Navigator.of(context).pop();
                            });
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
      )
    );
  }
}