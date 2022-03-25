import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import '../global/back_end_interface_url.dart';
import '../global/my_event_bus.dart';
import '../util/debug_print.dart';
import '../util/net/network_util.dart';


class EditOrder extends StatefulWidget {
  int id;

  EditOrder({Key? key, required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState()  => EditOrderState();
}

class EditOrderState extends State<EditOrder> {

  late TextEditingController _inspectSite; //站点名称
  late TextEditingController _inspectCategory; //巡检类别
  late TextEditingController _inspectContent;  //巡检内容
  late TextEditingController _inspectExeption; //巡检结果
  DateTime selectedDate1 = DateTime.now(); //开始时间
  TimeOfDay selectedTime1 = TimeOfDay.now();
  DateTime selectedDate2 = DateTime.now();//结束时间
  TimeOfDay selectedTime2 = TimeOfDay.now();

  String _selecting = "";
  List _imageString = [];


  final ImagePicker picker = new ImagePicker();
  List _imageList = []; //图片列表
  int _photoIndex = 0; //选择拍照还是相册的索引

  //action sheet
  List _actionSheet = [
    {"name": "拍照", "icon": Icon(Icons.camera_alt)},
    {"name": "相册", "icon": Icon(Icons.photo)}
  ];

  final ImagePicker _imagePicker = ImagePicker();
  //拍照或者相册选取图片，只能单选
  Future _getImage() async {
    Navigator.of(context).pop();
    XFile? image = await _imagePicker.pickImage(
        source: _photoIndex == 0 ? ImageSource.camera : ImageSource.gallery);

    //没有选择图片或者没有拍照
    if (image != null) {
      setState(() {
        _imageList.add(image);
      });
    }
  }

  //获取sheet选择
  Future _getActionSheet() async {
    await showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            padding: EdgeInsets.all(10.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _actionSheet.length,
              itemExtent: 50.0,
              itemBuilder: (innerCtx, i) {
                return ListTile(
                  title: Text(_actionSheet[i]["name"]),
                  leading: _actionSheet[i]["icon"],
                  onTap: () {
                    setState(() {
                      _photoIndex = i;
                    });
                    _getImage();
                  },
                );
              },
            ),
          );
        });
  }


  @override
  void initState() {
    super.initState();
    _inspectSite = TextEditingController();
    _inspectCategory = TextEditingController();
    _inspectContent = TextEditingController();
    _inspectExeption = TextEditingController();
    _inspectSite.text = "";

  }


  @override
  void dispose() {
    _inspectSite.dispose();
    _inspectCategory.dispose();
    _inspectContent.dispose();
    _inspectExeption.dispose();
    super.dispose();
  }

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
          title: const Text('填写巡检工单', style: TextStyle(color: Colors.white, fontSize: 20)),
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
                                      child: ListTile(title: Text('站点名称')),flex: 3),
                                  Expanded(child: ListTile(
                                    // contentPadding: const EdgeInsets.only(top: 10),
                                    title: TextField(
                                      controller: _inspectSite,
                                      decoration: const InputDecoration.collapsed(
                                        hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                                        hintText: "请输入站点名称（必填）",
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 1,
                                      // maxLength: 50,
                                    ),
                                  ),flex: 7),
                                ],
                              ),  //站点名称
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              Row(
                                children: [
                                  const Expanded(child: ListTile(title: Text('巡检类别')),flex: 2),
                                  Expanded(child: TextField(
                                    controller: _inspectCategory,
                                    enabled: false,
                                    decoration: const InputDecoration.collapsed(
                                      hintText: "请选择巡检类别（必填）",
                                      border: InputBorder.none,
                                    ),
                                  ),flex: 3),
                                  Expanded(child: ListTile(
                                    title: const Icon(Icons.keyboard_arrow_right),
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
                                              builder: (BuildContext context, void Function(void Function()) setState) {
                                                return AlertDialog(
                                                  title: const Text('巡检类别'),
                                                  content: Container(
                                                    height: MediaQuery.of(context).size.height * 0.18,
                                                    child:  Column(
                                                      children: [
                                                        RadioListTile<String>(
                                                            value: "设备类",
                                                            title: const Text("设备类"),
                                                            groupValue: _selecting,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                _selecting = value!;
                                                              });
                                                            }
                                                        ),
                                                        RadioListTile<String>(
                                                          value: "环境类",
                                                          title: const Text("环境类"),
                                                          groupValue: _selecting,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _selecting = value!;
                                                            });
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(child: const Text('取消'),onPressed: (){
                                                      Navigator.of(context).pop();
                                                    }),
                                                    TextButton(child: const Text('确认'),onPressed: (){
                                                      _inspectCategory.text = _selecting;
                                                      Navigator.of(context).pop();
                                                    },),
                                                  ],
                                                );
                                              },
                                            );
                                          }
                                      );
                                    },
                                  )
                                      ,flex: 1),
                                ],
                              ),  //巡检类别
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                      child: ListTile(title: Text('巡检内容')),flex: 2),
                                  Expanded(child: ListTile(
                                    contentPadding: const EdgeInsets.only(top: 10),
                                    title: TextField(
                                      controller: _inspectContent,
                                      decoration: const InputDecoration.collapsed(
                                        hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                                        hintText: "请填写巡检内容",
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 3,
                                      maxLength: 100,
                                    ),
                                  ),flex: 3),
                                  Expanded(child: Container(),flex: 1),
                                ],
                              ),  //巡检内容
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                      child: ListTile(title: Text('检查结果')),flex: 2),
                                  Expanded(child: ListTile(
                                    contentPadding: const EdgeInsets.only(top: 14),
                                    title: TextField(
                                      controller: _inspectExeption,
                                      decoration: const InputDecoration.collapsed(
                                        hintStyle: TextStyle(color: CupertinoColors.inactiveGray),
                                        hintText: "请填写检查结果",
                                        border: InputBorder.none,
                                      ),
                                      maxLines: 4,
                                      maxLength: 300,
                                    ),
                                  ),flex: 3),
                                  Expanded(child: Container(),flex: 1),
                                ],
                              ),  //检查结果
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              Row(
                                  children:[
                                    RaisedButton(
                                      child: Text("上传照片"),
                                      onPressed: () => _getActionSheet(),
                                    ),
                                    SizedBox(width: 8,),
                                    // Text("照片列表"),
                                    _imageList.isNotEmpty
                                        ? Wrap(
                                      spacing: 5.0,
                                      children: _getImageList(),
                                    )
                                        : Text("上传两张照片，包括巡检前、后照片", style: TextStyle( fontSize: 15))
                                  ]
                              ),  //上传照片
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              Row(
                                  children:[
                                    SizedBox(width: 10,),
                                    Text("开始时间"),
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
                              ),  //开始时间
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              Row(
                                  children:[
                                    SizedBox(width: 10,),
                                    Text("结束时间"),
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
                              ),    //结束时间
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
                                if (_inspectSite.text == "") {
                                  snackBar = const SnackBar(
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                    content: Text('站点名称不能为空!'),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                }else if (_inspectCategory.text == "") {
                                  snackBar = const SnackBar(
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                    content: Text('巡检类别不能为空!'),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else if (_inspectContent.text == "") {
                                  snackBar = const SnackBar(
                                    duration: Duration(seconds: 1),
                                    backgroundColor: Colors.red,
                                    content: Text('请填写巡检内容!'),
                                  );
                                  Scaffold.of(context).showSnackBar(snackBar);
                                } else {
                                  for (var element in _imageList) {
                                    _uploadImage(element);
                                  }
//2022-03-14 17:00:00
                                  HttpManager().put(updateOrderState, args: {'orderId': widget.id, 'orderState': '待评价'});
                                  String formattedDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', HH, ':', nn, ':', ss]);

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

                                  HttpManager().post(
                                      addPatrolOrderWorkerEdit,
                                      args: {
                                        'orderId': widget.id,
                                        'siteName': _inspectSite.text,
                                        'inspectionCategory': _inspectCategory.text,
                                        'inspectionContent': _inspectContent.text,
                                        'inspectionResult': _inspectExeption.text,
                                        'beginTime': realDate1,
                                        'endTime': realDate2,
                                        'photo1': _imageString[0],
                                        'photo2': _imageString[1],
                                      }
                                  );
                                  HttpManager().post(
                                      addOperationLog,
                                      args: {
                                        'orderId': widget.id,
                                        'operationTime': formattedDate,
                                        'operationName': '填写回单',
                                        'description': '【我】已经完成服务任务'
                                      }
                                  ).then((value){
                                    /// 提示用户抢单成功
                                    // Fluttertoast.showToast(
                                    //     msg: "抢单成功",
                                    //     toastLength: Toast.LENGTH_SHORT,
                                    //     gravity: ToastGravity.CENTER,
                                    //     backgroundColor: Colors.green,
                                    //     textColor: Colors.white,
                                    //     fontSize: 16.0
                                    // );
                                    eventBus.fire(RefreshOrderDetailEvent());
                                    eventBus.fire(InitOrderListEvent());
                                    /// 返回上一个界面
                                    Navigator.of(context).pop();
                                  });
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
  Dio _dio = Dio();

  //上传图片到服务器
  _uploadImage(XFile _image) async {
    FormData formData = FormData.fromMap({
      "pic": await MultipartFile.fromFile(_image.path, filename:"imageName.png"),
    });
    var response = await _dio.post(uploadImage, data: formData);

    _imageString.add("http://121.40.130.17:7777/images/${response}");
    print(_imageString);

  }

  //图片列表的刻画
  List<Widget> _getImageList() {
    return _imageList.map((img) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            Image.file(
              File(img!.path),
              fit: BoxFit.cover,
              width: 100.0,
              height: 70.0,
            ),
            Positioned(
              right: 5.0,
              top: 5.0,
              child: GestureDetector(
                child: ClipOval(
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    color: Colors.lightBlue,
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 12.0,
                    ),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _imageList.remove(img);
                  });
                },
              ),
            )
          ],
        ),
      );
    }).toList();
  }
}