import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import 'drawerContent.dart';
import 'newpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {

  String _choice = '无';

  final String state ='';

  Future _openAlertDialog() async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('你叫辣莫大声做什么'),
          content: const Text('那你去找物管啊！'),
          actions: <Widget>[
            TextButton(
              child: const Text('你再骂！'),
              onPressed: () {
                Navigator.pop(context, Action.Cancel);
              },
            ),
            TextButton(
              child: const Text('CNM！'),
              onPressed: () {
                Navigator.pop(context, Action.Ok);
              },
            ),
          ],
        );
      },
    );
    switch (action) {
      case Action.Ok:
        setState(() {
          _choice = 'CNM';
        });
        break;
      case Action.Cancel:
        setState(() {
          _choice = '你再骂';
        });
        break;
      default:
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
            child: Column(
              children: drawerContent
            )
        ),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => newpage(title: '联系方式', content: '联系方式')
                  ));
            },
          )
        ],
        title: const Text('智能巡检系统'),
        elevation: 0.0,
        centerTitle: true,
      ),
      body:Column(
        children: [
          Container(
            height: 200.0,
            child: Swiper(
              // 横向
              scrollDirection: Axis.horizontal,
              // 布局构建
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(
                  link[index],
                  fit: BoxFit.fill,
                );
              },
              itemCount: 3,
              autoplay: true,
              pagination: buildSwiperPagination(),
              onTap: (index) {
                print(" 点击 " + index.toString());
              },
              viewportFraction: 1,
              autoplayDisableOnInteraction: true,
              loop: true,
              scale: 0.8,
            ),
          ),
          SizedBox(height: 15),
          Divider(height: 5,indent: 80,thickness: 2,endIndent: 80,),
          SizedBox(height: 30,
          child: Text('功能区',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800))),
          Divider(height: 5,indent: 80,thickness: 2,endIndent: 80,),
          Wrap(
            spacing: 15,
            runSpacing: 20,
           children: [
             Column(
               children: const [
                 InkWell(
                   child: Opacity(
                     opacity: 1,
                     child: Icon(Icons.assignment_turned_in,size: 80,color: Colors.deepOrange,),
                   ),
                 ),
                 Text('发布工单')
               ],
             ),
             Column(
               children: const [
                 InkWell(
                   child: Opacity(
                     opacity: 1,
                     child: Icon(Icons.article,size: 80,color: Colors.deepOrange,),
                   ),
                 ),
                 Text('公告')
               ],
             ),
             Column(
               children: const [
                 InkWell(
                   child: Opacity(
                     opacity: 1,
                     child: Icon(Icons.manage_accounts,size: 80,color: Colors.deepOrange,),
                   ),
                 ),
                 Text('巡检人员管理')
               ],
             ),
             Column(
               children: const [
                 InkWell(
                   child: Opacity(
                     opacity: 1,
                     child: Icon(Icons.grade,size: 80,color: Colors.deepOrange,),
                   ),
                 ),
                 Text('评分')
               ],
             ),
             Column(
               children: const [
                 InkWell(
                   child: Opacity(
                     opacity: 1,
                     child: Icon(Icons.view_list,size: 80,color: Colors.deepOrange,),
                   ),
                 ),
                 Text('菜单管理')
               ],
             ),
             Column(
               children: const [
                 InkWell(
                   child: Opacity(
                     opacity: 1,
                     child: Icon(Icons.account_circle,size: 80,color: Colors.deepOrange,),
                   ),
                 ),
                 Text('我的')
               ],
             )
             ],
          )
        ],
      ),
    );
  }
  buildSwiperPagination() {
    // 分页指示器
    return const SwiperPagination(
      //指示器显示的位置
      alignment: Alignment.bottomCenter, // 位置 Alignment.bottomCenter 底部中间
      // 距离调整
      margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
      // 指示器构建
      builder: DotSwiperPaginationBuilder(
        // 点之间的间隔
          space: 2,
          // 没选中时的大小
          size: 6,
          // 选中时的大小
          activeSize: 12,
          // 没选中时的颜色
          color: Colors.black54,
          //选中时的颜色
          activeColor: Colors.white),
    );
  }
}
enum Action {
  Ok,
  Cancel
}
GetImg(index){
  return Image.asset(
    link[index],
    fit: BoxFit.fill,
  );
}
List <String>link = ['img/3.jpg','img/4.jpg','img/5.jpg'];
// Container(
// padding: const EdgeInsets.all(16.0),
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.center,
// children: <Widget>[
// Text('Your choice is: $_choice'),
// const SizedBox(height: 16.0),
// Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: <Widget>[
// ElevatedButton(
// child: const Text('模拟孙笑川'),
// onPressed: _openAlertDialog,
// ),
// ElevatedButton(
// child: const Text('跳转至新界面并传值，同时保存'),
// onPressed: () async {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => JumpPage(data: _choice),
// ),
// );
// SharedPreferences prefs = await SharedPreferences.getInstance();
// prefs.setString(state, _choice);
// }
// ),
// ]
// ),
// ElevatedButton(
// child: const Text('获取保存值'),
// onPressed: () async {
// SharedPreferences saved = await SharedPreferences.getInstance();
// String? data = saved.getString(state);
// ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("数据获取成功：$data")));
// }
// ),
// ],
// ),
// ),