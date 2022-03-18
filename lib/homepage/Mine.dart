import 'package:flutter/material.dart';

import '../global/theme.dart';

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
        backgroundColor: mainColor,
        elevation: 0.5,
        title: Text("我的"),
      ),
      body: Center(
        child: Text("我的"),
      ),
    );
  }
}