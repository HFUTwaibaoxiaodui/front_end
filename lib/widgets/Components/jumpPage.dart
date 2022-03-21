import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class JumpPage extends StatelessWidget{
  final String data;

  const JumpPage({Key? key, required this.data}) : super(key: key);
@override
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: new Center(
        child: Text('得到的值为: ${data}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //返回上一级页面
          Navigator.of(context).pop();
        },
        child: Text("返回"),
      ),

    );
  }
}