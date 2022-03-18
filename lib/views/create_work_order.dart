import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import '../main.dart';


class CreateOrder extends StatefulWidget {
  @override
  State<StatefulWidget> createState()  => CreateOrderState();
}

class CreateOrderState extends State<CreateOrder> {

  late TextEditingController _inspectCreatorId;
  late TextEditingController _inspectTitle;
  late TextEditingController _inspectContent;
  late TextEditingController _inspectAddress;
  String _selecting = "";


  @override
  void initState() {
    super.initState();
    _inspectCreatorId = TextEditingController();
    _inspectTitle = TextEditingController();
    _inspectContent = TextEditingController();
    _inspectAddress = TextEditingController();
    _inspectCreatorId.text = "";
  }


  @override
  void dispose() {
    _inspectCreatorId.dispose();
    _inspectTitle.dispose();
    _inspectContent.dispose();
    _inspectAddress.dispose();
    super.dispose();
  }


  DateTime selectedDate1 = DateTime.now();
  // TimeOfDay selectedTime = TimeOfDay(hour: 9, minute: 30);
  TimeOfDay selectedTime1 = TimeOfDay.now();

  DateTime selectedDate2 = DateTime.now();
  TimeOfDay selectedTime2 = TimeOfDay.now();

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
                                      child: ListTile(title: Text('创建者id')),flex: 3),
                                  Expanded(child: ListTile(

                                    // contentPadding: const EdgeInsets.only(top: 10),
                                    title: TextField(
                                      controller: _inspectCreatorId,
                                      decoration: const InputDecoration.collapsed(
                                        hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                                        hintText: "请输入创建者id（必填）",
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 1,
                                      // maxLength: 50,
                                    ),
                                  ),flex: 7),
                                ],
                              ),  //创建者id
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
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
                                if (_inspectCreatorId.text == "") {
                                  snackBar = const SnackBar(
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                    content: Text('创建者id不能为空!'),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }else if (_inspectTitle.text == "") {
                                  snackBar = const SnackBar(
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                    content: Text('工单标题不能为空!'),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else if (_inspectAddress.text == "") {
                                  snackBar = const SnackBar(
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                    content: Text('请填写巡检地址!'),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
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
        )
    );
  }
}