import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../global/back_end_interface_url.dart';
import '../global/user_info.dart';
import '../util/net/network_util.dart';
import 'OrderSelectPeople.dart';


class CreateOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  => CreateOrderState();
}

class CreateOrderState extends State<CreateOrder> {

  late TextEditingController _inspectTitle;    //工单标题
  // late TextEditingController _inspectCode;    //工单编号
  late TextEditingController _inspectContent;  //工单内容
  late TextEditingController _inspectWorker;  //工单人员
  late TextEditingController _inspectAddress;  //工单地址
  String _selecting = "";


  @override
  void initState() {
    super.initState();
    _inspectTitle = TextEditingController();
    // _inspectCode = TextEditingController();
    _inspectContent = TextEditingController();
    _inspectWorker = TextEditingController();
    _inspectAddress = TextEditingController();
  }


  @override
  void dispose() {
    _inspectTitle.dispose();
    // _inspectCode.dispose();
    _inspectContent.dispose();
    _inspectWorker.dispose();
    _inspectAddress.dispose();
    super.dispose();
  }


  DateTime selectedDate1 = DateTime.now();
  // TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 30);
  TimeOfDay selectedTime1 = TimeOfDay.now();

  DateTime selectedDate2 = DateTime.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();

  int workerId = 0;

  Future<void> _selectDate1() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    setState(() {
      selectedDate1 = date;
    });
  }

  Future<void> _selectDate2() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate2,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    setState(() {
      selectedDate2 = date;
    });
  }

  Future<void> _selectTime1() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime1,
    );

    if (time == null) return;

    setState(() {
      selectedTime1 = time;
    });
  }

  Future<void> _selectTime2() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime2,
    );

    if (time == null) return;

    setState(() {
      selectedTime2 = time;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('创建工单', style: TextStyle(color: Colors.white, fontSize: 20)),
          centerTitle: true,
          backgroundColor: Colors.cyanAccent.shade700,
          // 底部阴影
          elevation: 0.5,
        ),
        body: Builder(
          builder: (context) {
            return
              ListView(
                children: [
                  Container(
                    color: Colors.grey.shade300,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.80,
                          color: Colors.white,
                          child: ListView(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                      child: ListTile(title: Text('工单标题')),flex: 3),
                                  Expanded(child: ListTile(
                                    // contentPadding: const EdgeInsets.only(top: 10),
                                    title: TextField(
                                      controller: _inspectTitle,
                                      decoration: const InputDecoration.collapsed(
                                        hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                                        hintText: "请输入工单标题（必填）",
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 1,
                                      // maxLength: 50,
                                    ),
                                  ),flex: 7),
                                ],
                              ),  //工单标题
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                      child: ListTile(title: Text('巡检地址')),flex: 3),
                                  Expanded(child: ListTile(
                                    // contentPadding: const EdgeInsets.only(top: 10),
                                    title: TextField(
                                      controller: _inspectAddress,
                                      decoration: const InputDecoration.collapsed(
                                        hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                                        hintText: "请输入巡检地址（必填）",
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 1,
                                      // maxLength: 50,
                                    ),
                                  ),flex: 7),
                                ],
                              ),  //巡检地址
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                      child: ListTile(title: Text('工单描述')),flex: 2),
                                  Expanded(child: ListTile(
                                    contentPadding: const EdgeInsets.only(top: 10),
                                    title: TextField(
                                      controller: _inspectContent,
                                      decoration: const InputDecoration.collapsed(
                                        hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                                        hintText: "请填写工单描述",
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 4,
                                      maxLength: 150,
                                    ),
                                  ),flex: 3),
                                  Expanded(child: Container(),flex: 1),
                                ],
                              ),  //工单描述
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                      child: ListTile(title: Text('工单人员')),flex: 2),
                                  Expanded(child: ListTile(
                                    // contentPadding: const EdgeInsets.only(top: 10),
                                    title: TextField(
                                      enabled: false,
                                      controller: _inspectWorker,
                                      decoration: const InputDecoration.collapsed(
                                        hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                                        hintText: "请输入工单人员（必填）",
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 1,
                                      // maxLength: 50,
                                    ),
                                  ),flex: 4),
                                  Expanded(child: ListTile(
                                    title: const Icon(Icons.keyboard_arrow_right),
                                    onTap: ()
                                      async {
                                        //经过路由跳转从子页面中传递过来的数据，都是异步的
                                        var result = await Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>const OrderSelectPeoplePage()
                                            )
                                        );
                                        setState(() {
                                          workerId = result['id'];
                                          _inspectWorker.text = result['name'];
                                        });
                                      },
                                  )
                                ),
                                ]
                              ),  //工单人员
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              SizedBox(height: 10,),
                              Row(
                                  children:[
                                    SizedBox(width: 10,),
                                    Text("期望开始时间"),
                                    SizedBox(width: 40,),
                                    InkWell(
                                      onTap: _selectDate1,
                                      child: Row(
                                        children: <Widget>[
                                          Text(DateFormat.yMMMMd().format(selectedDate1)),
                                          Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: _selectTime1,
                                      child: Row(
                                        children: <Widget>[
                                          Text(selectedTime1.format(context)),
                                          Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                  ]
                              ),  //期望开始时间
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              SizedBox(height: 10,),
                              Row(
                                  children:[
                                    SizedBox(width: 10,),
                                    Text("期望结束时间"),
                                    SizedBox(width: 40,),
                                    InkWell(
                                      onTap: _selectDate2,
                                      child: Row(
                                        children: <Widget>[
                                          Text(DateFormat.yMMMMd().format(selectedDate2)),
                                          Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: _selectTime2,
                                      child: Row(
                                        children: <Widget>[
                                          Text(selectedTime2.format(context)),
                                          Icon(Icons.arrow_drop_down),
                                        ],
                                      ),
                                    ),
                                  ]
                              ),  //期望结束时间
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          // padding: const EdgeInsets.all(10),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                SnackBar snackBar;
                                if  (_inspectTitle.text == "") {
                                  snackBar = const SnackBar(
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                    content: Text('工单标题不能为空!'),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }
                                else if (_inspectAddress.text == "") {
                                  snackBar = const SnackBar(
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                    content: Text('请填写巡检地址!'),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  DateTime datetime1 = DateTime(
                                      selectedDate1.year,
                                      selectedDate1.month,
                                      selectedDate1.day,
                                      selectedTime1.hour,
                                      selectedTime1.minute,
                                      0
                                  );
                                  DateTime datetime2 = DateTime(
                                      selectedDate2.year,
                                      selectedDate2.month,
                                      selectedDate2.day,
                                      selectedTime2.hour,
                                      selectedTime2.minute,
                                      0
                                  );
                                  String realDate1 = formatDate(datetime1,  [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);
                                  String realDate2 = formatDate(datetime2,  [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);

                                  if(_inspectWorker.text==''){
                                    HttpManager().post(
                                        addPatrolOrder,
                                        args: {
                                          // 'creatorId': Provider.of<UserInfo>(context, listen: false).accountId,
                                          'creatorId': 1,
                                          'orderTitle': _inspectTitle.text,
                                          'orderAddress':_inspectAddress.text,
                                          'orderDescription':_inspectContent.text,
                                          // 'workerId':'',
                                          'orderState':"待抢单",
                                          'planStartTime':realDate1,
                                          'planEndTime':realDate2,
                                        }
                                    );
                                  }else{
                                    HttpManager().post(
                                        addPatrolOrder,
                                        args: {
                                          // 'creatorId': Provider.of<UserInfo>(context, listen: false).accountId,
                                          'workerId': workerId.toString(),
                                          'creatorId': 1,
                                          'orderTitle': _inspectTitle.text,
                                          'orderDescription':_inspectContent.text,
                                          'orderState' :"待抢单",
                                          'orderAddress' : _inspectAddress.text,
                                          'planStartTime':realDate1,
                                          'planEndTime':realDate2,
                                    }
                                    );
                                  };
                                  /// 返回上一个界面
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Container(
                                color: Colors.cyanAccent.shade700,
                                child: const Center(
                                  child: Text('提交', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18)
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
          },
        ),
    );
  }
}