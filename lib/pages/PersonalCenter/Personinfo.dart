import 'dart:async';
import 'dart:convert';

import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/global/my_event_bus.dart';
import 'package:frontend/global/theme.dart';
import 'package:frontend/global/user_info.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../global/back_end_interface_url.dart';
import '../../global/constant/constant.dart';
import '../../util/net/network_util.dart';
import '../../util/toast_util.dart';
import 'ChangeAddress.dart';
import 'ChangeArea.dart';
import 'ChangePhone.dart';
import 'ChangeRealName.dart';
import 'package:http/http.dart' as Http;

class Personinfo extends StatefulWidget {
  const Personinfo({Key? key}) : super(key: key);

  @override
  _PersoninfoState createState() => _PersoninfoState();
}


//头像布局
class SettingHead extends StatelessWidget {
  
  final VoidCallback? onPressed;

  SettingHead({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: InkWell(
          onTap: onPressed,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: const Text('头像管理',
                              style:
                              TextStyle(fontSize: 14, color: Colors.black)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: ClipOval(
                      child: Provider.of<UserInfo>(context).buildImage(context),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 15),
                        child: Image.asset(
                          Constant.ASSETS_IMG + "ic_arrow_right.png",
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
                //  margin: EdgeInsets.only(left: 60),
              ),
            ],
          )),
    );
  }


}

//普通条目布局
class SettingCommon extends StatelessWidget {

  final VoidCallback? onPressed;

  const SettingCommon({this.title, this.content, this.onPressed});

  final String? title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                ),
                child: IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 15.0),
                          child: Text(title ?? 'null',
                              style:
                              TextStyle(fontSize: 13, color: Colors.black)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(content ?? 'null',
                            style:
                            TextStyle(fontSize: 12, color: Colors.grey)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 5.0, right: 15),
                        child: Image.asset(
                          Constant.ASSETS_IMG + "ic_arrow_right.png",
                          width: 15,
                          height: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 0.5,
                color: Colors.black12,
                //  margin: EdgeInsets.only(left: 60),
              ),
            ],
          ),
        ));
  }
}



final ImagePicker picker = new ImagePicker();
XFile? imageChoose; //图片列表
int _photoIndex = 0; //选择拍照还是相册的索引

List _actionSheet = [
  {"name": "拍照", "icon": Icon(Icons.camera_alt)},
  {"name": "相册", "icon": Icon(Icons.photo)}
];
//, elevation: 0.5


class _PersoninfoState extends State<Personinfo> {
  String _realName = '';
  String _area = '';
  String _phone = '';
  String _address = '';
  String _imagePath = '';
  
  late StreamSubscription _updatepeopleInfoSubscription;
  late StreamSubscription _upRealName;
  late StreamSubscription _upPhone;
  late StreamSubscription _upArea;
  
  Dio _dio = Dio();
  String _imageString = "";

  @override
  void initState() {
    setState(() {
      getPersonInfo();
    });
    // _address = Provider.of<UserInfo>(context).address.toString();
    super.initState();
    _updatepeopleInfoSubscription = eventBus.on<UpdatePeopleInfoEvent>().listen((event) {
      setState(() {
        _address = event.peopleInfo;
      });
    });
    _upRealName = eventBus.on<UpRealname>().listen((event) {
      setState(() {
        _realName = event.peopleInforealname;
      });
    });
    _upPhone = eventBus.on<UpPhone>().listen((event) {
      setState(() {
        _phone = event.peopleInfophone;
      });
    });
    _upArea = eventBus.on<UpArea>().listen((event) {
      setState(() {
        area1 = event.peopleInfoarea;
      });
    });
  }
  @override
  void dispose() {
    _updatepeopleInfoSubscription.cancel();
    _upRealName.cancel();
    _upPhone.cancel();
    _upArea.cancel();
    super.dispose();
  }

  String area1='';
  String area2='';

  //拍照或者相册选取图片，只能单选
  Future _getImage() async {
    Navigator.of(context).pop();
    var _image = await picker.pickImage(source: _photoIndex == 0 ? ImageSource.camera : ImageSource.gallery);
    //没有选择图片或者没有拍照
    if (_image != null) {
      setState(() {
        imageChoose = _image;
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


  //上传图片到服务器
  _uploadImage(XFile _image) async {
    FormData formData = FormData.fromMap({
      "pic": await MultipartFile.fromFile(_image.path, filename:"imageName.png"),
    });
    _dio.post(uploadImage, data: formData).then((value){
      setState(() {
        _imageString ="http://121.40.130.17:7777/images/${value}";
        Provider.of<UserInfo>(context, listen: false).imagePath = _imageString;
      });
      print(_imageString);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('========1'+_realName.length.toString()+_phone.length.toString()+_address.length.toString()+_area+'========');
    return Scaffold(
            appBar: AppBar(
                title: const Text(
                  '个人主页',
                  style: TextStyle(fontSize: 15,color: Colors.white),
                ),
                backgroundColor: mainColor,
                elevation: 0.5),
            body: Container(
              color: const Color(0xffF2F2F2),
              child: ListView(
                children: <Widget>[
                  SettingHead(
                    onPressed: () {
                        _getActionSheet();
                        _uploadImage(imageChoose!);
                        setState(() {
                          getPersonInfo();
                        });
                        HttpManager().put(
                          updateInformation,
                          args: {
                            'accountId': Provider.of<UserInfo>(context, listen: false).accountId,
                            'imagePath': _imageString
                          }
                        );
                    }
                  ),
                  SettingCommon(
                      title: "账户id",
                      content: Provider.of<UserInfo>(context,listen: false).accountId.toString(),
                      onPressed: () {

                        // Routes.navigateTo(context, '${Routes.changeNickNamePage}');
                      }),
                  SettingCommon(
                      title: "用户名称",
                      // content: Provider.of<UserInfo>(context).realName,
                      content: _realName,
                      onPressed: () {
                        Navigator.of(context).push(
                            CupertinoPageRoute(builder: (BuildContext context){
                              return ChangeRealName();})
                        );
                      }),

                  SettingCommon(
                      title: "地区",
                      // content: area1.length>0 ? area1:Provider.of<UserInfo>(context,listen: false).area,
                      content: area1.length>0 ? area1: _area,
                      onPressed:() {
                        CityPickers.showCityPicker(context: context).then((value){
                          setState(() {
                            _area = value!.provinceName! + ' ' + value.cityName! + ' ' + value.areaName!;
                            _updateArea({
                              "accountId": Provider.of<UserInfo>(context,listen: false).accountId,
                              "accountName": "",
                              "accountState": "",
                              "accountType": "",
                              "address": "",
                              "area": _area,
                              "currentTime": "",
                              "firstLetter": "",
                              "imagePath": "",
                              "password": "",
                              "phone": "",
                              "realName": "",
                            });
                          });

                          eventBus.fire(UpArea(peopleInfoarea: _area));
                        });

                      }),
                  SettingCommon(
                      title: "具体所在地",
                      content: _address.isEmpty ? Provider.of<UserInfo>(context,listen: false).address : _address,
                      onPressed: () {
                        Navigator.of(context).push(
                            CupertinoPageRoute(builder: (BuildContext context){
                              return Changeaddress();})
                        );
                      }),
                  SettingCommon(
                      title: "手机号",
                      // content: Provider.of<UserInfo>(context).phone,
                      content: _phone.isEmpty ? Provider.of<UserInfo>(context,listen: false).phone : _phone,
                      onPressed: () {
                        Navigator.of(context).push(
                            CupertinoPageRoute(builder: (BuildContext context){
                              return ChangePhone();})
                        );
                      }),
                  SettingCommon(
                      title: "状态",
                      content: Provider.of<UserInfo>(context,listen: false).accountState,
                      onPressed: () {
                        // ToastUtil.show('暂未开发!');
                      }),
                  Container(
                    height: 30,
                    color: Color(0xffF2F2F2),
                    //  margin: EdgeInsets.only(left: 60),
                  ),
                  Container(
                    height: 30,
                    color: Color(0xffF2F2F2),
                    //  margin: EdgeInsets.only(left: 60),
                  ),
                ],
              ),
            ),
          );
  }
  void _updateArea(var post) async{
    var addput = await Http.put(
        Uri.parse(updateInformation),
        headers: {"content-type" : "application/json"},
        body: json.encode(post)
    ).then((value){
      ToastUtil.show('修改成功!');
      // Navigator.of(context).pop(context);
    });
  }

  late var post = {
    "accountId": Provider.of<UserInfo>(context,listen: false).accountId,
    "accountName": "",
    "accountState": "",
    "accountType": "",
    "address": "",
    "area": _area,
    "currentTime": "",
    "firstLetter": "",
    "imagePath": "",
    "password": "",
    "phone": "",
    "realName": "",
  };

  void getPersonInfo() async{
    HttpManager().get(selectAccountById, args: {'accountId' : Provider.of<UserInfo>(context,listen: false).accountId}).then((value){
      setState(() {
        _imagePath = value['imagePath'];
        _realName = value['realName'];
        _phone = value['phone'];
        _address = value['address'];
        _area = value['area'];
      });
      print('========2'+_realName+_phone+_address+_area+'========');
    });
  }
}