
// import 'dart:_http';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/pages/homepage/Person_Manage.dart';
import '../../global/theme.dart';
import '../../util/net/network_util.dart';
import '../order_detail.dart';
import 'package:frontend/pages/PersonManager/People.dart ';
import 'package:http/http.dart' as Http;
import 'dart:convert';
import 'package:frontend/global/back_end_interface_url.dart';


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
      body:_gridViewDemo(context),
    );
  }



  Widget _gridViewDemo(BuildContext context) {
    return GridView(
      padding: EdgeInsets.only(left: 16.0,right: 16.0,top: 16.0),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:4 ,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 1
      ),
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            //背景
            color: mainColor,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
            //设置四周边框
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child:GestureDetector(child: Icon(Icons.account_box,color: Colors.white, ),
            onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return PeoplesPage();
            }));
          },),
        ),
        Container(
          decoration: BoxDecoration(
            //背景
            // color: mainColor,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
            //设置四周边框
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child:GestureDetector(child: Icon(Icons.account_box,color: mainColor, ),
            onTap: (){
              _postData();
            },),
        ),
        Container(
          color: Colors.grey,
        ),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.blue,
        ),
      ],
    );
  }

  void _postData() async{
    HttpManager().get(
      getOrderById,
      args: {
        'orderId': 1
      }
    ).then((value){
      print(value);
    });
  }

}
