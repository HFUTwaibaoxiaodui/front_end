import 'package:flutter/material.dart';
import 'package:frontend/global/user_info.dart';
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
  @override
  void initState() {
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

