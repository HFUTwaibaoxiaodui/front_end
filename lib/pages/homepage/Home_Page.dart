import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/global/user_info.dart';
import 'package:frontend/pages/today_work.dart';
import 'package:frontend/pages/yest_work.dart';
import 'package:frontend/pages/message.dart';
import 'package:provider/provider.dart';

import '../../global/my_event_bus.dart';
import '../../global/theme.dart';
import '../../widgets/order_list.dart';
import '../month_work.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}


class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  String? yest_work = '0';

  String? month_work = '0';

  String? today_work = '12';

  int wait_work = 0;

  late TabController _tabController;
  late StreamSubscription _updateOrderSubscription;


  final List<String> _tabValues = [
    '待抢单',
    '待服务',
    '服务中',
    '待评价',
    '已完成'
  ];

 final String _initState = '待抢单';

  @override
  void initState() {
    print('123123');
    super.initState();

    _tabController = TabController(length: _tabValues.length, vsync: this);
    _updateOrderSubscription = eventBus.on<UpdateOrderNumEvent>().listen((event) {
      setState(() {
        wait_work = event.num;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _updateOrderSubscription.cancel();
    super.dispose();
  }

  Widget _buildOrderListView() {
    if (Provider.of<UserInfo>(context).accountType == 'USER') {
      return Column(
        children: [
          TabBar(
            isScrollable: true,
            controller: _tabController,
            labelColor: mainColor,
            unselectedLabelColor: Colors.black,
            tabs: _tabValues.map( (v) => Tab(text: v) ).toList(),
            indicatorColor: mainColor,
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (int index) {
              eventBus.fire(UpdateTabViewEvent(state: _tabValues[index]));
              eventBus.fire(InitOrderListEvent());
            },
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.58,
            child: OrderListWidget(
              withStatus: _initState,
            ),
          ),
        ],
      );
    } else {
      return Column (
        children: [
          ListTile(
            title: Text(
              '待处理工单($wait_work)',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.58,
            child: OrderListWidget(
              withStatus: _initState,
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(child: const Icon(Icons.swap_horiz),onTap: (){
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
          _buildOrderListView()
        ],
      ),
    );
  }
}
