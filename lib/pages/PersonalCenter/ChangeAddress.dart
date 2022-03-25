import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/util/toast_util.dart';
import 'package:random_string/random_string.dart' as PP;
import 'package:provider/provider.dart';
import 'package:frontend/util/net/network_util.dart';
import '../../global/back_end_interface_url.dart';
import '../../global/my_event_bus.dart';
import '../../global/user_info.dart';

import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'package:frontend/global/back_end_interface_url.dart';



//修改昵称界面
class Changeaddress extends StatefulWidget {
  const Changeaddress({Key? key,}) : super(key: key);

  @override
  _ChangeaddressState createState() => _ChangeaddressState();
}

class _ChangeaddressState extends State<Changeaddress> {
  final TextEditingController _mEtController = TextEditingController();

  @override
  String mInputaddress = "";


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
              '修改详细地址',
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
                            hintText: "请输入您的详细地址",
                            hintStyle:
                            TextStyle(color: Color(0xff999999), fontSize: 13),
                            contentPadding: EdgeInsets.only(left: 15, right: 15),
                            border: InputBorder.none,
                          ),
                          // onChanged: (mInputName) {
                          //   print('========'+mInputName);
                          //   // setState(() {
                          //   //   UserInfo().realName = mInputName;
                          //   // });
                          // },
                        ),
                      )),

                  Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
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
                            ToastUtil.show('地址不能为空!');
                            return;}
                          else{
                            mInputaddress = _mEtController.text;
                            eventBus.fire(UpdatePeopleInfoEvent(peopleInfo: mInputaddress));
                            _update(post);
                            Navigator.of(context).pop(context);
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
      ToastUtil.show('修改成功!');
      eventBus.fire(RefreshOrderDetailEvent());
      eventBus.fire(InitOrderListEvent());

    });
  }

  late var post = {
    "accountId": Provider.of<UserInfo>(context,listen: false).accountId,
    "accountName": "",
    "accountState": "",
    "accountType": "",
    "address": mInputaddress,
    "area": "",
    "currentTime": "",
    "firstLetter": "",
    "imagePath": "",
    "password": "",
    "phone": "",
    "realName": "",
  };


}

