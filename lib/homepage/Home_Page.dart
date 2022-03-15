import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/homepage/list_view.dart';

class HomePage extends StatelessWidget {
  String? today_work='0' ;
  String? yest_work='0' ;
  String? month_work='0' ;
  String? wait_work='0' ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Column(
        children: [
          Container(
            height: 120,
            color: Colors.blue,

            child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,

            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('$today_work',
                    style: TextStyle(fontSize: 18,color: Colors.white),),
                  Text('今日处理工单',
                    style: TextStyle(fontSize: 18,color: Colors.white),),
                ],
              ),
              SizedBox(
                width: 1,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('$yest_work',
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
                Text('昨日处理工单',
                  style: TextStyle(fontSize: 18,color: Colors.white),),
              ],),
              SizedBox(
                width: 1,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text('$month_work',
                  style: TextStyle(fontSize: 18,color: Colors.white),),
                Text('本月处理工单',
                  style: TextStyle(fontSize: 18,color: Colors.white),),
              ],),
            ],
          ),
          ),
          
          Container(
            height: 40,
            padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('待处理工单($wait_work)',style: TextStyle(fontSize: 16,color: Colors.black),),
                IconButton(
                  icon: (new Icon(Icons.place)),
                  color: Colors.lightBlue,
                  onPressed: (){},
                ),
              ],
            ),
          ),

          Container(
            height: 440,
            color: Colors.grey,
            child: ListViewPage(),
          ),


        ],
      ),
    );
  }
}

