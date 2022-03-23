
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/global/back_end_interface_url.dart';
import 'package:city_pickers/city_pickers.dart';
import '../../util/net/network_util.dart';
import '../../widgets/bezierContainer.dart';
import 'loginPage.dart';
import 'package:dio/dio.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

Dio dio = Dio();

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _userController = TextEditingController();
  late final TextEditingController _phoneController = TextEditingController();
  late final TextEditingController _pswdController = TextEditingController();
  late final TextEditingController _nameController = TextEditingController();
  late final TextEditingController _addressController = TextEditingController();
  late final TextEditingController _areaController = TextEditingController();
  late String _username = '';
  late String _phone = '';
  late String _password = '';
  late String _name = '';
  late String _address = '';
  late String _area = '';

  @override
  void initState() {
    _userController.addListener(() {
      _username = _userController.text;
    });
    _phoneController.addListener(() {
      _phone = _phoneController.text;
    });
    _pswdController.addListener(() {
      _password = _pswdController.text;
    });
    _areaController.addListener(() {
      _area = _areaController.text;
    });
    _nameController.addListener(() {
      _name = _nameController.text;
    });
    _addressController.addListener(() {
      _address = _addressController.text;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<TextInputFormatter> format = [];

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('返回',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _userentryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: _userController,
              validator: (value) {
                if (value!.length > 20) {
                  return '账号名称长度不能超过20个字符';
                }
                if (value == "" || value == null) {
                  return '账号不能为空';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _phoneentryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: _phoneController,
              validator: (value) {
                if (value == "" || value == null) {
                  return '手机号码不能为空';
                } else if (!RegExp(
                        '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
                    .hasMatch(value)) {
                  return '手机号码格式错误';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _pswdentryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: _pswdController,
              obscureText: isPassword,
              validator: (value) {
                String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
                if (value!.length < 8) {
                  return '密码至少需要8位';
                }
                if (!_matchPattern(pattern, value)) {
                  return "必须包含大写字母，小写字母，数字和特殊字符";
                } else if (value == "") {
                  return "密码不能为空";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _nameentryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == "") {
                  return "姓名不能为空";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _addressentryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: _addressController,
              validator: (value) {
                if (value == "") {
                  return "地址不能为空";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _areaentryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            readOnly: true,
            controller: _areaController,
              validator: (value) {
                if (value == "") {
                  return "地区不能为空";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.expand_more,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                      CityPickers.showCityPicker(context: context).then((value){
                        setState(() {
                          _areaController.text = value!.provinceName! + ' ' + value.cityName! + ' ' + value.areaName!;
                        });
                      });
                    },
                  ),
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        _checkForReturn(context);
      },
      child: Container(
        width: (MediaQuery.of(context).size.width),
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.cyan, Colors.cyanAccent])),
        child: const Text(
          '注册',
          style: TextStyle(fontSize: 20, color: Color(0xffffffff)),
        ),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '已经有账户了?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => LoginPage()),
                    (Route<dynamic> route) {
                  return route.isFirst;
                });
              },
              child: const Text(
                '登录',
                style: TextStyle(
                    color: Color(0xff03bfbf),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        text: '账号注册',
        style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xff17a9c2)),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Container(
      height: MediaQuery.of(context).size.height/2,
      child: ListView(
        children: <Widget>[
          _userentryField("用户名"),
          _phoneentryField("手机号"),
          _pswdentryField("密码"),
          _nameentryField('姓名'),
          _areaentryField('地区'),
          _addressentryField('地址')
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * 0.15),
                    _title(),
                    SizedBox(
                      height: 30,
                    ),
                    Form(
                      child: _emailPasswordWidget(),
                      key: _formKey,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }

  bool _matchPattern(String pattern, String src) {
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(src);
  }

  Future<void> _checkForReturn(context) async {
    if (_formKey.currentState!.validate()) {
      infomodel account=infomodel(_username, _phone, _password, _name, _address, _area);

      Map<String, dynamic> maptest= {
        "accountName": _username,
        "password": _password,
        "realName": _name,
        "phone":_phone,
        "area":_area,
        "address":_address
      };
      var jsonVar = json.encode(account.toJson());
      print(jsonVar);
   //   ContentType contentType = ContentType.parse("application/x-www-form-urlencoded");
      dio.options.contentType = "application/json";
      Response response = await dio.post(
          signin,
          data: jsonVar
      );
      print(response.data);
      if(response.data.toString() == '手机号重复'){
        Fluttertoast.showToast(
          msg: "注册失败，手机号有重复",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.grey,
        );
      }else if(response.data.toString() == '用户名重复') {
        Fluttertoast.showToast(
          msg: "注册失败，手机号有重复",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.grey,
        );
      }else{
        Fluttertoast.showToast(
          msg: "注册成功，跳转至登录页",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 2,
          textColor: Colors.grey,
        );
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const LoginPage()),
                (Route<dynamic> route) {
              return route.isFirst;
            });
      }
    }
  }
}
class infomodel{
  late String accountName;
  late String phone;
  late String password;
  late String realName;
  late String address;
  late String area;
  infomodel(String a,String p,String ps,String r,String ad,String ar){
    this.accountName=a;
    this.phone=p;
    this.password=ps;
    this.realName=r;
    this.address=ad;
    this.area=ar;
  }
  Map<String, String> toJson() => {
    "accountName": accountName,
    "password": password,
    "realName": realName,
    "phone":phone,
    "area":area,
    "address":address
  };
}