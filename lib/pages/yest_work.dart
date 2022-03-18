import 'package:flutter/material.dart';

class YestPage extends StatefulWidget {
  const YestPage({Key? key}) : super(key: key);

  @override
  _YestPageState createState() => _YestPageState();
}

class _YestPageState extends State<YestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("昨日处理工单"),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.blue,
          child: Text("有状态组件"),
        ),
      ),
    );
  }
}
