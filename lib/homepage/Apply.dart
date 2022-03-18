import 'package:frontend/routes/order_detail.dart';
import 'package:flutter/material.dart';

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
        centerTitle: true,
        title: Text("应用"),
      ),
      body:Center(
        child: Text("应用"),
      ),
    );
  }
}
