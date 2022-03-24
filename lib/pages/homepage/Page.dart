import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/global/user_info.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';
import 'Mine.dart';
import 'Work_Order.dart';
import 'Apply.dart';
import 'Home_Page.dart';


class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<IndexPage> {
  late String counter;

  late final List<Widget> _pages;

  late final BottomNavigationBarItem _home;
  late final BottomNavigationBarItem _orders;
  late final BottomNavigationBarItem _application;
  late final BottomNavigationBarItem _mine;

  late final List<BottomNavigationBarItem> _bottomItems;

  int currentIndex = 0;
  late Map<dynamic,dynamic> notification;

  JPush jPush = JPush();
  String idLabel = "";
  Future<void> initPlatFormState() async {

    String platform = '';

    try {
      jPush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
            print("接收到的通知是:$message");
            setState(() {
              notification = message;
              print(json.decode(notification['extras']['cn.jpush.android.EXTRA'])['orderId']);
            });
          },
          onOpenNotification: (Map<String, dynamic> message) async {
            print("通过点击推送进入app：$message");
          },
          onReceiveMessage: (Map<String, dynamic> message) async {
            print("接收到自定义消息：$message");
            setState(() {
            });
          },
          onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
            print("通知权限发生变更：$message");
          });
    } on PlatformException {
      platform = "平台版本获取失败";
    }

    jPush.setup(
        appKey: "8a44ad1f8ca8a48a829f31f5",
        channel: "theChannel",
        production: false,
        debug: true
    );

    jPush.setAlias(Provider.of<UserInfo>(context, listen: false).accountId.toString());

    jPush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    jPush.getRegistrationID().then((rid) {
      print("获得的注册id为：" + rid);
      setState(() {
        idLabel = "当前注册id为：$rid";
      });
    });
  }
  @override
  void initState() {
    initPlatFormState();
    super.initState();
    currentIndex = 0;
    counter='12';

    _home = BottomNavigationBarItem(
      icon: Stack(
        children: <Widget>[
          const Icon(Icons.home),
          Positioned(
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(6),
              ),
              constraints: const BoxConstraints(
                minHeight: 12,
                minWidth: 12,
              ),
              child: Text(
                counter,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      // icon: Icon(Icons.home),
      label: "首页",
    );
    _orders = const BottomNavigationBarItem(
      // backgroundColor: Colors.green,
      icon: Icon(Icons.message),
      label: "工单",
    );
    _application =  const BottomNavigationBarItem(
      // backgroundColor: Colors.amber,
      icon: Icon(Icons.apps),
      label: "应用",
    );
    _mine =  const BottomNavigationBarItem(
      // backgroundColor: Colors.red,
      icon: Icon(Icons.person),
      label: "我的",
    );

    if (Provider.of<UserInfo>(context, listen: false).accountType == 'ADMIN') {
      _bottomItems = [_home, _orders, _application, _mine];
      _pages = [HomePage(),WorkOrderPage(),ApplyPage(),MinePage()];
    } else {
      _bottomItems = [_home, _orders, _mine];
      _pages = [HomePage(),WorkOrderPage(), MinePage()];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        fixedColor: Colors.blue,
        items: _bottomItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          _changePage(index);
        },
      ),
      // body: pages[currentIndex],
      body: IndexedStack(
        index: currentIndex,
        children: _pages,
      ),
    );
  }

  /*切换页面*/
  void _changePage(int index) {
    /*如果点击的导航项不是当前项  切换 */
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}

