import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/PersonalCenter/Personinfo.dart';
import 'package:frontend/constant/constant.dart';
import 'package:path/path.dart';

class PersonData extends StatefulWidget {
  const PersonData({Key key}) : super(key: key);

  @override
  _PersonDataState createState() => _PersonDataState();
}

class _PersonDataState extends State<PersonData> {
  @override
  // void initState() {
  //   super.initState();
  //   Constant.eventBus.on<ChangeInfoEvent>().listen((event) {
  //     setState(() {
  //       print("接收更换个人信息的消息");
  //     });
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text(
            '我的工单数据',
            style: TextStyle(fontSize: 15,color:Colors.white),
          ),
          elevation: 0.5),
      body: Container(),
    );
  }
}