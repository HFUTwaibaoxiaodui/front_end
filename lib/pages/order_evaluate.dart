import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';


class OrderEvaluate extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  => OrderEvaluateState();
}

class OrderEvaluateState extends State<OrderEvaluate> {

  late TextEditingController _handleOption;
  late TextEditingController _handleSuggest;
  late FocusNode _focusNode;
  String _selecting = "";

  @override
  void initState() {
    super.initState();

    _handleOption = TextEditingController();
    _handleSuggest = TextEditingController();
    _focusNode = FocusNode();
    _handleOption.text = "";

    _focusNode.addListener((){
      if (_focusNode.hasFocus) {
      }else{
        print('失去焦点');
      }
    });
  }

  @override
  void dispose() {
    _handleOption.dispose();
    _handleSuggest.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工单评价', style: TextStyle(color: Colors.white, fontSize: 20)),
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
                  height: MediaQuery.of(context).size.height * 0.3,
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          const Expanded(child: ListTile(title: Text('问题解决情况')),flex: 2),
                          Expanded(child: TextField(
                            controller: _handleOption,
                            enabled: false,
                            decoration: const InputDecoration.collapsed(
                              hintText: "请选择问题解决情况（必填）",
                              border: InputBorder.none,
                            ),
                          ),flex: 3),
                          Expanded(child: ListTile(
                            title: const Icon(Icons.keyboard_arrow_right),
                            onTap: () {
                              showDialog(
                                  context: navigatorKey.currentContext!,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(
                                      builder: (BuildContext context, void Function(void Function()) setState) {
                                        return AlertDialog(
                                          title: const Text('问题解决情况'),
                                          content: Container(
                                            height: MediaQuery.of(context).size.height * 0.23,
                                            child:  Column(
                                              children: [
                                                RadioListTile<String>(
                                                    value: "已解决",
                                                    title: const Text("已解决"),
                                                    groupValue: _selecting,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _selecting = value!;
                                                      });
                                                    }
                                                ),
                                                RadioListTile<String>(
                                                    value: "未解决",
                                                    title: const Text("未解决"),
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
                                              _handleOption.text = _selecting;
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
                          const Expanded(child: ListTile(title: Text('处理意见')),flex: 2),
                          Expanded(child: ListTile(
                            contentPadding: const EdgeInsets.only(top: 14),
                            title: TextField(
                              focusNode: _focusNode,
                              controller: _handleSuggest,
                              decoration: const InputDecoration.collapsed(
                                hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                                hintText: "处理意见",
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
                          if (_handleOption.text == "") {
                            snackBar = const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.red,
                              content: Text('问题解决情况不能为空!'),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else if (_handleSuggest.text == "") {
                            snackBar = const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.red,
                              content: Text('请填写处理意见!'),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else {
                            switch (_handleOption.text) {
                              case "取消工单":
                              /// 取消订单 TODO
                                Navigator.of(context).pop();
                                break;
                              case "驳回请求":
                              /// 驳回请求 TODO
                                Navigator.of(context).pop();
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
    );
  }
}