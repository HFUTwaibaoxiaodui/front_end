import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/homepage/list_view.dart';
import 'package:frontend/routes/today_work.dart';
import 'package:frontend/routes/yest_work.dart';
import 'package:frontend/routes/month_work.dart';
import 'package:frontend/routes/message.dart';

class HomePage extends StatelessWidget {
  String? today_work = '12';

  String? yest_work = '0';

  String? month_work = '0';

  String? wait_work = '12';

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
            height: 120,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: GestureDetector(
                        child: Text(
                          '$yest_work',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
                        child: Text(
                          '昨日处理工单',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
                  height: 50,
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: GestureDetector(
                        child: Text(
                          '$month_work',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
                        child: Text(
                          '本月处理工单',
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
          Container(
            height: 40,
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  '待处理工单($wait_work)',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                IconButton(
                  icon: (new Icon(Icons.place)),
                  color: Colors.lightBlue,
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Container(
            height: 440,
            color: Colors.grey,
            child: ListViewPage(),
          ),
        ],
      ),
    );
  }
}
