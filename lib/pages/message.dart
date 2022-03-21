import 'package:flutter/material.dart';

class MessagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("消息"),
      ),
      body: const Center(
        child: Text("消息"),
      ),
    );
  }
}