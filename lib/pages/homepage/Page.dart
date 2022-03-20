import 'package:flutter/material.dart';
import 'Mine.dart';
import 'Work_Order.dart';
import 'Apply.dart';
import 'Home_Page.dart';


class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<IndexPage> {
  late String counter;

  late final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
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
    ),
    const BottomNavigationBarItem(
      // backgroundColor: Colors.green,
      icon: Icon(Icons.message),
      label: "工单",
    ),
    const BottomNavigationBarItem(
      // backgroundColor: Colors.amber,
      icon: Icon(Icons.apps),
      label: "应用",
    ),
    const BottomNavigationBarItem(
      // backgroundColor: Colors.red,
      icon: Icon(Icons.person),
      label: "我的",
    ),
  ];

  int currentIndex = 0;

  final pages = [HomePage(),WorkOrderPage(),ApplyPage(),MinePage(),];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    counter='12';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        fixedColor: Colors.blue,
        items: bottomNavItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          _changePage(index);
        },
      ),
      // body: pages[currentIndex],
      body: IndexedStack(
        index: currentIndex,
        children: pages,
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

