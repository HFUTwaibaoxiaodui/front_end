import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/util/toast_util.dart';
import 'package:random_string/random_string.dart';

import '../../global/user_info.dart';

//修改昵称界面
class ChangeRealName extends StatefulWidget {
  @override
  _ChangeRealNameState createState() => _ChangeRealNameState();
}

class _ChangeRealNameState extends State<ChangeRealName> {
  TextEditingController _mEtController = new TextEditingController();

  //#F3F1F4
  String mInputName = "";

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
                          controller: _mEtController,
                          decoration: const InputDecoration(
                            hintText: "请输入您的姓名",
                            hintStyle:
                            TextStyle(color: Color(0xff999999), fontSize: 13),
                            contentPadding: EdgeInsets.only(left: 15, right: 15),
                            border: InputBorder.none,
                          ),
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
                          }
                          // else
                          //   return Provider.of<UserInfo>(context).realName = _mEtController.text;
                        },
                        //   FormData params = FormData.fromMap({
                        //     'userId': UserUtil.getUserInfo().id,
                        //     'nick': _mEtController.text
                        //   });
                        //   DioManager.getInstance()
                        //       .post(ServiceUrl.updateNick, params, (data) {
                        //     ToastUtil.show('修改姓名成功!');
                        //     UserUtil.saveUserNick(_mEtController.text);
                        //     Constant.eventBus.fire(ChangeInfoEvent());
                        //     Navigator.pop(context);
                        //   }, (error) {
                        //     ToastUtil.show(error);
                        //   });

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
}