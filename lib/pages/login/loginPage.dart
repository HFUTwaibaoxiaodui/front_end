import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../global/back_end_interface_url.dart';
import '../homepage/Page.dart';
import 'signup.dart';
import '../../widgets/bezierContainer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

Dio dio = Dio();

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool pswdvisible;
  late final TextEditingController _passwordController = TextEditingController();
  late final TextEditingController _usernameController = TextEditingController();
  late String _username = '';
  late String _password = '';

  @override
  void initState() {
    pswdvisible=true;
    _usernameController.addListener(() {
      _username = _usernameController.text;
    });
    _passwordController.addListener(() {
      _password = _passwordController.text;
    });
  }

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

  Widget _pswdEntryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: _passwordController,
              validator: (value) {
                if (value == "") {
                  return "密码不能为空";
                } else {
                  return null;
                }
              },
              obscureText: pswdvisible,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      !pswdvisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColorDark,
                    ),
                    onPressed: () {
                        setState(() {
                          pswdvisible=!pswdvisible;
                          print(pswdvisible);
                        });
                    },
                  ),
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _usernameentryField(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
              controller: _usernameController,
              validator: (value) {
                if (value == "") {
                  return "用户名不能为空";
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
          '登录',
          style: TextStyle(fontSize: 20, color: Color(0xffffffff)),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('或'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _wechatButton() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Image.asset('icon48_wx_button.png',fit:BoxFit.scaleDown)
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '还没有账号 ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => SignUpPage()),
                        (Route<dynamic> route) {
                      return route.isFirst;
                    });
              },
              child:Text('注册',
                style: TextStyle(
                    color: Color(0xff17a9c2),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),)

            ),
          ],
        ),
      );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: '智慧',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Color(0xff17a9c2)
          ),
          children: [
            TextSpan(
              text: '巡检',
              style: TextStyle(color: Color(0xff17a9c2), fontSize: 30),
            ),
            TextSpan(
              text: '系统',
              style: TextStyle(color: Color(0xff17a9c2), fontSize: 30),
            ),
          ]),
    );
  }

  Widget _accountPasswordWidget() {
    return Column(
      children: <Widget>[
        _usernameentryField("账号"),
        _pswdEntryField("密码"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer()),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  Form(
                    child: _accountPasswordWidget(),
                    key: _formKey,
                  ),
                  SizedBox(height: 20),
                  _submitButton(),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: const Text('忘记密码?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  // _divider(),
                  // _wechatButton(),
                  // SizedBox(height: height * .055),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: _backButton()),
        ],
      ),
    ));
  }
  Future<void> _checkForReturn(context) async {
    if (_formKey.currentState!.validate()) {
      infomodel account = infomodel(_username,_password);
      Response response = await dio.post(
          logIn,
          queryParameters: {
            'username':account.accountName,
            'password':account.password
          }
      );
      // print(response.data);
      // print(json.decode(response.data)['token']);
      if(response.data.toString() == 'false'){
        Fluttertoast.showToast(
          msg: "登录失败，账号或密码错误",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.grey,
        );
      }else
        {
          var username=json.decode(response.data)['token'];
          Fluttertoast.showToast(
            msg: "登陆成功\n欢迎您，$username",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            textColor: Colors.grey,
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => IndexPage()),
                  (Route<dynamic> route) {
                return route.isFirst;
              });
        }

    }
  }
}
class infomodel{
  late String accountName;
  late String password;

  infomodel(String a,String p){
    this.accountName=a;
    this.password=p;

  }
  Map<String, String> toJson() => {
    "accountName": accountName,
    "password": password,
  };
}
