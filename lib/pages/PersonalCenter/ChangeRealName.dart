import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/util/toast_util.dart';
import 'package:random_string/random_string.dart' as PP;
import 'package:provider/provider.dart' ;
import 'package:frontend/util/net/network_util.dart';
import '../../global/back_end_interface_url.dart';
import '../../global/my_event_bus.dart';
import '../../global/user_info.dart';

import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'package:frontend/global/back_end_interface_url.dart';



//修改昵称界面
class ChangeRealName extends StatefulWidget {
  const ChangeRealName({Key? key,}) : super(key: key);



  @override
  _ChangeRealNameState createState() => _ChangeRealNameState();
}

class _ChangeRealNameState extends State<ChangeRealName> {

  final TextEditingController _mEtController = TextEditingController();
  @override
  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController();
  //   _controller.addListener(() {});
  // }
  //接受修改信息的
  String minputrealName = "";

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan,
            leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: const Text(
              '修改姓名',
              style: TextStyle(fontSize: 15),
            ),
            elevation: 0.5,
            centerTitle: true,
          ),
          body: Container(
              color: Color(0xffF3F1F4),
              child: Column(
                children: <Widget>[
                  Container(
                      height: 50,
                      color: Color(0xffffffff),
                      margin: EdgeInsets.only(top: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextField(
                          // onChanged: (text) {
                          //   setState(() {
                          //     _mEtController.text = ;
                          //   });
                          // },

                          controller: _mEtController,
                          decoration: const InputDecoration(
                            // labelText: "请输入您的姓名",
                            hintText: "请输入您的姓名",
                            hintStyle:
                            TextStyle(color: Color(0xff999999), fontSize: 13),
                            contentPadding: EdgeInsets.only(left: 15, right: 15),
                            border: InputBorder.none,
                          ),
                          // onChanged: (minputrealName) {
                          //   print('========'+minputrealName);
                          //   // setState(() {
                          //   //   UserInfo().realName = minputrealName;
                          //   // });
                          // },
                        ),
                      )),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: const Text(
                          "4-30个字符,支持中英文、数字",
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xff999999)),
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Color(0xffFF8200),
                        textColor: Colors.white,
                        disabledTextColor: Colors.white,
                        disabledColor: Color(0xffFFD8AF),
                        elevation: 0,
                        disabledElevation: 0,
                        highlightElevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25.0),
                            topLeft: Radius.circular(25.0),
                            bottomRight: Radius.circular(25.0),
                            bottomLeft: Radius.circular(25.0),
                          ),
                        ),
                        onPressed: () {
                          if (_mEtController.text.isEmpty) {
                            ToastUtil.show('姓名不能为空!');
                            return;
                          } else{
                            minputrealName = _mEtController.text;
                            _update(post);
                          }
                        },

                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                          child: Text(
                            "修改",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ));
  }
  void _update(var post) async{
    var addput = await Http.put(
        Uri.parse(updateInformation),
        headers: {"content-type" : "application/json"},
        body: json.encode(post)
    ).then((value){
      ToastUtil.show('修改姓名成功!');
          eventBus.fire(RefreshOrderDetailEvent());
          eventBus.fire(InitOrderListEvent());
          Navigator.of(context).pop(context);
    });
    print('===================');
    print(addput.body.toString());
    print(addput.statusCode.toString());
  }

  late var post = {
    "accountId": 1,
    "accountName": "why",
    "accountState": "正常",
    "accountType": "ADMIN",
    "address": "安徽省合肥市",
    "area": "安徽省-合肥市-蜀山区",
    "currentTime": "2022-03-23T03:07:02.205Z",
    "firstLetter": "string",
    "imagePath": "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.daimg.com%2Fuploads%2Fallimg%2F200515%2F1-200515164137.jpg&refer=http%3A%2F%2Fimg.daimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=auto?sec=1650183945&t=97d7c899493b0f52d4ab3bf404ad9680",
    "password": "string",
    "phone": "18857743243",
    "realName": minputrealName
  };
}

