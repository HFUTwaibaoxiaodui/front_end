import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("消息"),
      ),
      body: Center(
        child: Text("消息"),
      ),
    );
  }
}