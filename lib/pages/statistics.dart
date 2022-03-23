import 'dart:convert';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/global/back_end_interface_url.dart';
import 'package:frontend/global/theme.dart';
import 'package:frontend/global/user_info.dart';
import 'package:frontend/util/net/network_util.dart';
import 'package:provider/provider.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);
  @override
  _StatisticPage createState() => _StatisticPage();
}

class _StatisticPage extends State<StatisticsPage>{

  List <charts.Series<barstats,String>> list = [];
  late Map<dynamic,dynamic> _datalist123={};
  double temp =0;

  @override
  void initState() {
    HttpManager().get(getmonthlyData,args: {'accountId':Provider.of<UserInfo>(context, listen: false).accountId}).then((value){
      setState(() {
        _datalist123=value;
        print(_datalist123);
        List<charts.Series<barstats, String>> _createData() {
          final createData = [
            barstats(_datalist123['previousMonthCreatedOrder'], '上月'),
            barstats(_datalist123['currentMonthCreatedOrder'], '本月'),

          ];
          final finishedData = [
            barstats(_datalist123['previousMonthFinishOrder'], '上月'),
            barstats(_datalist123['currentMonthFinishOrder'], '本月'),

          ];
          final exceptionData = [
            barstats(_datalist123['previousMonthExceptionOrder'], '上月'),
            barstats(_datalist123['currentMonthExceptionOrder'], '本月'),

          ];
          return [
            charts.Series<barstats, String>(
              id: '创建的工单',
              domainFn: (barstats sales, _) => sales.month,
              measureFn: (barstats sales, _) => sales.num,
              data: createData,
                labelAccessorFn: (barstats sales, _) => sales.num.toString()
            ),
            charts.Series<barstats, String>(
              id: '完成的工单',
              domainFn: (barstats sales, _) => sales.month,
              measureFn: (barstats sales, _) => sales.num,
              data: finishedData,
              labelAccessorFn: (barstats sales, _) => sales.num.toString()
            ),
            charts.Series<barstats, String>(
              id: '异常工单',
              domainFn: (barstats sales, _) => sales.month,
              measureFn: (barstats sales, _) => sales.num,
              data: exceptionData, labelAccessorFn: (barstats sales, _) => '${sales.num.toString()}'
            ),
          ];
        }
        list=_createData();
        if(_datalist123['currentMonthCreatedOrder']==0){
          temp=0;
        }else{
          temp=_datalist123['currentMonthFinishOrder']/_datalist123['currentMonthCreatedOrder'];
        }
      });
    });



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text('工单报表'),
      ),
      body: ListView(
          children: [
            SizedBox(height: 10,),
            Container(
              child: Row(
                children: [Text('我的工单数据',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900))],
                mainAxisAlignment: MainAxisAlignment.center)
            ),
            Divider(
              height: 20,
              thickness:1 ,
              color: Colors.grey,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,width: 2),
                borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
              child: Column(
                children: [
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    smallBox('本月创建工单数', _datalist123['currentMonthCreatedOrder']),
                    smallBox('本月完成工单数', _datalist123['currentMonthFinishOrder'])
                  ],
                ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      smallBox('本月异常工单数', _datalist123['currentMonthExceptionOrder']),
                      smallBox('工单完成率', temp)
                    ],
                  )
                ],
              ),
            ),
            Divider(
              height: 20,
              thickness:1 ,
              color: Colors.grey,
            ),
            Container(
                child: Row(
                    children: [Text('工单数量趋势',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900))],
                    mainAxisAlignment: MainAxisAlignment.center)
            ),
            Divider(
              height: 20,
              thickness:1 ,
              color: Colors.grey,
            ),
            Container(
              width: double.infinity,
              height: 300,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: charts.BarChart(list,
                barGroupingType: charts.BarGroupingType.grouped,
                barRendererDecorator: charts.BarLabelDecorator<String>(),
                  behaviors: [
                    // Add the sliding viewport behavior to have the viewport center on the
                    // domain that is currently selected.
                    new charts.SlidingViewport(),
                    // A pan and zoom behavior helps demonstrate the sliding viewport
                    // behavior by allowing the data visible in the viewport to be adjusted
                    // dynamically.
                    new charts.PanAndZoomBehavior(),
                    new charts.SeriesLegend(entryTextStyle: charts.TextStyleSpec(
                      fontSize: 12,
                      color: charts.Color.black,
                    )),
                  ],
              )
            )
          ],
        ),
    );
  }
Widget smallBox(title,content){
  return Container(
    height: 100,
    width: 150,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 1),//边框
      borderRadius: BorderRadius.all(Radius.circular(7.0),
      ),
    ),
    child:Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('$title',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700))],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('$content',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))],
          ),
        )
      ],
    ),
  );
}
}
class barstats{
  int num;
  String month;

  barstats(this.num,this.month);
}
