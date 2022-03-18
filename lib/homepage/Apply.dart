import 'package:flutter/material.dart';

import '../global/theme.dart';
import '../pages/order_detail.dart';

class ApplyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(child: Icon(Icons.swap_horiz),onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return DetailPage();
          }));
        },),
        backgroundColor: mainColor,
        elevation: 0.5,
        centerTitle: true,
        title: Text("应用"),
      ),
      body:Center(
        child: Text("应用"),
      ),
    );
  }
}
