import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/homepage/list_view.dart';
import 'package:frontend/pages/today_work.dart';
import 'package:frontend/pages/yest_work.dart';
import 'package:frontend/pages/message.dart';

import '../global/my_event_bus.dart';
import '../global/theme.dart';
import '../pages/month_work.dart';
import '../widgets/order_list.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}


class HomePageState extends State<HomePage> {

  String? yest_work = '0';

  String? month_work = '0';

  String? today_work = '12';

  int wait_work = 0;


  @override
  void initState() {
    print('123123');
    eventBus.on<UpdateOrderNum>().listen((event) {
      setState(() {
        wait_work = event.num;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(child: Icon(Icons.swap_horiz),onTap: (){
          // Navigator.push(context, MaterialPageRoute(builder: (_) {
          //   return DetailPage();
          // }));
        },),
        centerTitle: true,
        title: Text("机房巡检"),
        elevation: 0.5,
        backgroundColor: mainColor,
        actions: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton (
                icon:Icon(Icons.notifications_none),
                onPressed:(){
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return MessagePage();
                  }));

                },),
            ),

          )
        ],

      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.14,
            color: mainColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: GestureDetector(
                        child: Text(
                          '$today_work',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return TodayPage();
                          }));
                        },
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: Text(
                          '今日处理工单',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return TodayPage();
                          }));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 1,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: GestureDetector(
                        child: Text(
                          '$yest_work',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return YestPage();
                          }));
                        },
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: const Text(
                          '昨日处理工单',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return YestPage();
                          }));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 1,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey.shade200),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: GestureDetector(
                        child: Text(
                          '$month_work',
                          style: const TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return MonthPage();
                          }));
                        },
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                        child: const Text(
                          '本月处理工单',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                            return MonthPage();
                          }));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              '待处理工单($wait_work)',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            trailing: IconButton(
              icon: (new Icon(Icons.place)),
              color: Colors.lightBlue,
              onPressed: () {},
            ),
          ),
          // Container(
          //   height: 40,
          //   padding: EdgeInsets.all(5),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     mainAxisSize: MainAxisSize.max,
          //     children: [
          //
          //       IconButton(
          //         icon: (new Icon(Icons.place)),
          //         color: Colors.lightBlue,
          //         onPressed: () {},
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            height: MediaQuery.of(context).size.height * 0.58,
            color: Colors.grey,
            child: OrderListWidget(),
          ),
        ],
      ),
    );
  }
}
