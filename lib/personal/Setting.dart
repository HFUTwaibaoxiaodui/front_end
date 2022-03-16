import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/personal/Personal.dart';
import 'package:frontend/constant/constant.dart';
import 'package:path/path.dart';

class Setting extends StatefulWidget {
  const Setting({Key key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

//普通条目布局
class SettingCommon extends StatelessWidget {
  final VoidCallback onPressed;

  const SettingCommon({this.title, this.content, this.onPressed});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Text(title,
                              style:
                              TextStyle(fontSize: 13, color: Colors.black)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(content,
                            style:
                            TextStyle(fontSize: 14, color: Colors.black)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 15),
                        child: Image.asset(
                          Constant.ASSETS_IMG + "ic_arrow_right.png",
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
                //  margin: EdgeInsets.only(left: 60),
              ),
            ],
          ),
        ));
  }
}

//, elevation: 0.5
class _SettingState extends State<Setting> {
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
          title: const Text(
            '设置',
            style: TextStyle(fontSize: 15),
          ),
          elevation: 0.5),
      body: Container(
        color: Color(0xffF2F2F2),
        child: ListView(
          children: <Widget>[
            SettingCommon(
                title: "主题",
                content: "",
                onPressed: () {
                  // Routes.navigateTo(context, '${Routes.changeDescPage}');
                }),
            SettingCommon(
                title: "语言",
                content: "",
                onPressed: () {
                  //  ToastUtil.show('暂未开发!');
                }),
            SettingCommon(
                title: "关于我们",
                content: "",
                onPressed: () {
                  // ToastUtil.show('暂未开发!');
                }),
            Container(
              height: 30,
              color: Color(0xffF2F2F2),
              //  margin: EdgeInsets.only(left: 60),
            ),
            SettingCommon(title: "版本检查", content: ""),
            SettingCommon(title: "清理缓存", content: ""),
            Container(
              height: 30,
              color: Color(0xffF2F2F2),
              //  margin: EdgeInsets.only(left: 60),
            ),
            Material(
              color: Colors.white,
              child: InkWell(
                  onTap: () {
                    //Routes  .navigateTo(context, '${Routes.settingPage}');
                    showDialog(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: const Text('退出登录?',style: TextStyle(fontSize: 13),),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('确定',style: TextStyle(fontSize: 13),),
                              onPressed: () {
                                // UserUtil.loginout();
                                // Navigator.of(context).pop();
                                // Routes.navigateTo(
                                //     context, '${Routes.loginPage}',
                                //     clearStack: true,
                                //     transition: TransitionType.fadeIn);
                              },
                            ),
                            FlatButton(
                              child: const Text('取消',style: TextStyle(fontSize: 13),),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                          backgroundColor: Colors.white,
                          elevation: 20,
                          // 设置成 圆角
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 15.0,
                    ),
                    child: const Center(
                      child: Text('退出登录',
                          style: TextStyle(fontSize: 13, color: Colors.red)),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}