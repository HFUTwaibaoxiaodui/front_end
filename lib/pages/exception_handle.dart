import 'package:flutter/material.dart';


class ExceptionHandle extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  => ExceptionHandleState();
}

class ExceptionHandleState extends State<ExceptionHandle> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('异常处理', style: TextStyle(color: Colors.white, fontSize: 20)),
          centerTitle: true,
          backgroundColor: Colors.cyanAccent.shade700,
          // 底部阴影
          elevation: 0.5,
        ),
    );
  }
}