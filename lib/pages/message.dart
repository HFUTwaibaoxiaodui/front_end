import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/global/theme.dart';
import 'package:date_format/date_format.dart';
import 'package:frontend/global/user_info.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);
  @override
  _Messagepage createState() => _Messagepage();
}
class _Messagepage extends State<MessagePage>{
  @override
  void initState() {
    super.initState();
    initPlatFormState();
  }
  String customMessage='' ;

  late Map<dynamic,dynamic> notification;

  JPush jPush = JPush();

  String idLabel = "";

  List<Widget> listview= [];

  Future<void> initPlatFormState() async {

    String platform = '';

    try {
      jPush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
            print("接收到的通知是:$message");
            setState(() {
              notification=message;
              print(json.decode(notification['extras']['cn.jpush.android.EXTRA'])['orderId']);
              listview.add(_singleMessage(notification['title'], notification['alert'],json.decode(notification['extras']['cn.jpush.android.EXTRA'])['time']));
            });
          },
          onOpenNotification: (Map<String, dynamic> message) async {
        print("通过点击推送进入app：$message");
      },
          onReceiveMessage: (Map<String, dynamic> message) async {
        print("接收到自定义消息：$message");
        setState(() {
          customMessage=json.encode(message);
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


  Widget _singleMessage(title,content,time){
      return Container(
        margin: const EdgeInsets.only(right: 20, left: 10),
        child: InkWell(
          onTap: (){
          },
          child: Column(
            children: [SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child:Row(
                      children:[
                        CircleAvatar(
                          radius: 27,
                          backgroundImage: NetworkImage('https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fnews.yzz.cn%2Fpublic%2Fimages%2F110111%2F68_102448_4abb2_lit.jpg&refer=http%3A%2F%2Fnews.yzz.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1649250305&t=6a671e69a69338ae3c36edec77b2907d')
                      ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LimitedBox(
                                child: Text('$title',maxLines: 1,overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w900))
                            ),
                            SizedBox(height: 20),
                            LimitedBox(
                                child: Text('[HFUT]$content，点击查看详情>>>>',maxLines: 2,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500))
                            ),
                          ],
                        )
                      ]
                  )
                  ),
                  Expanded(
                    flex: 1,
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(time,style: TextStyle(fontSize: 8)),
                        SizedBox(height: 50)
                      ],
                    )
                    ,
                  )
                ],
              ),
              SizedBox(height: 20),
              Divider(height: 1)
            ],
          ),
        ),
      );
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text("消息"),
        actions: [IconButton(onPressed: (){
          initPlatFormState();
        }, icon: Icon(Icons.refresh))],
      ),
      body: Container(
        child: ListView.builder(
            itemCount: listview.length,
            itemBuilder: (context,index){
              return listview[index];
            })
        ),
    );
  }
  getTimeStr() {
    var now = DateTime.now();
    var format = [yyyy, '-', mm, '-', dd, " ", HH, ":", mm, ":", ss];
    //打印时间 格式
    var time = formatDate(now, format);
    return time;
  }
}
class messagemodel{
  late String title;
  late String content;
}