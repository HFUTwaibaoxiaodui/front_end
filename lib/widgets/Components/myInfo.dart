import 'package:flutter/material.dart';

import 'drawerContent.dart';

class MyPageWidget extends StatefulWidget {
  const MyPageWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyPageWidgetState();
  }
}

class MyPageWidgetState extends State<MyPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Column(
        children: drawerContent
      )),
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: const Center(
        child: Icon(
          Icons.mood,
          size: 130.0,
          color: Colors.blue,
        ),
      ),
    );
  }
}
