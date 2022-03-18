import 'package:flutter/material.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(child: Icon(Icons.swap_horiz),onTap: (){
          // Navigator.push(context, MaterialPageRoute(builder: (_) {
          //   return DetailPage();
          // }));
        },),
        centerTitle: true,
        title: Text("我的"),
      ),
      body: Center(
        child: Text("我的"),
      ),
    );
  }
}