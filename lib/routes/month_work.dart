import 'package:flutter/material.dart';

class MonthPage extends StatefulWidget {
  const MonthPage({Key? key}) : super(key: key);

  @override
  _MonthPageState createState() => _MonthPageState();
}

class _MonthPageState extends State<MonthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("今日处理工单"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.blue,
          child: Text("有状态组件"),
          // Text("有状态组件 路由传参：content=${this.arguments['content']}  状态改变：$counter"),
        ),
      ),
    );
  }
}
