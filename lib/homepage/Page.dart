import 'package:flutter/material.dart';
import 'package:frontend/homepage/Apply.dart';
import 'package:frontend/homepage/Mine.dart';
import 'package:frontend/homepage/Work_Order.dart';
import 'package:frontend/homepage/Home_Page.dart';


class IndexPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IndexState();
  }
}

class _IndexState extends State<IndexPage> {
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      backgroundColor: Colors.blue,
      icon: Icon(Icons.home),
      label: "首页",
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.green,
      icon: Icon(Icons.message),
      label: "工单",
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.amber,
      icon: Icon(Icons.settings),
      label: "应用",
    ),
    BottomNavigationBarItem(
      backgroundColor: Colors.red,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("机房巡检"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.shifting,
        onTap: (index) {
          _changePage(index);
        },
      ),
      body: pages[currentIndex],
      //左边抽屉
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                "赵某人",
                style: TextStyle(
                  fontSize: 25 ,
                ),

              ),
              accountEmail: Text("9658****253@qq.com"),
              otherAccountsPictures: [
                Icon(Icons.camera,
                  color: Colors.white,)
              ],
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/girl.jpg") ,
                    fit: BoxFit.fill
                ),

              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage("images/girl2.jpeg"),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text("开通会员"),
              // subtitle: Text("必须要充钱"),
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("分享"),
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("我的收藏"),
            ),
            ListTile(
              leading: Icon(Icons.error),
              title: Text("关于"),
            )
          ],
        ),
      ),
      //右边抽屉
      endDrawer: Drawer(
        child: MediaQuery.removePadding(
          context: context, // removeTop: true,//移除抽屉菜单顶部默认留白
          child: ListView(
            children: <Widget>[
              ListTile(leading: const Icon(Icons.add), title: const Text('Add account0')),
              ListTile(leading: const Icon(Icons.add), title: const Text('Add account1')),
              ListTile(leading: const Icon(Icons.add), title: const Text('Add account2')),
              ListTile(leading: const Icon(Icons.add), title: const Text('Add account3')),
            ],
          ),
        ),
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

