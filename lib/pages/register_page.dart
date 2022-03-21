import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/Register_main.dart';
import 'package:frontend/widgets/Components/dynamicCode/code_main.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool _isButtonEnable = true;
  int count = 60;
  late Timer timer;
  String buttonText = '发送验证码';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController _passwordEditController;
  late FocusNode _accountFocus;
  late FocusNode _phoneFocus;
  late FocusNode _passwordFocus;
  late FocusNode _nextPasswordFocus;
  late FocusNode _checkCodeFocus;

  TelAndSmsService _service = locator<TelAndSmsService>();

  void _buttonClickListen() {
    setState((){
      if (_isButtonEnable) {
        _isButtonEnable = false;
        _initTimer();
      }
    });
  }

  void _initTimer() {
    timer = Timer.periodic(const Duration(milliseconds: 200), (Timer timer) {
      count--;
      setState(() {
        if (count == 0) {
          timer.cancel(); //倒计时结束取消定时器
          _isButtonEnable = true; //按钮可点击
          count = 60; //重置时间
          buttonText = '发送验证码'; //重置按钮文本
        } else {
          buttonText = '请等待($count)'; //更新文本内容
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _accountFocus = FocusNode();
    _phoneFocus = FocusNode();
    _passwordFocus = FocusNode();
    _nextPasswordFocus = FocusNode();
    _checkCodeFocus = FocusNode();
    _passwordEditController = TextEditingController();
    timer = Timer(const Duration(), () {});
  }

  @override
  void dispose() {
    timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
            child: Center(
              child: SingleChildScrollView(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){_lostAllFocus();},
                        child: Center(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.9,
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.blueAccent,
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10)),
                                ]),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height * 0.10,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.blue.shade400,
                                              Colors.lightBlue.shade100
                                            ])),
                                    child: const Center(
                                        child: Text('注册',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 36,
                                                letterSpacing: 10,
                                                color: Colors.black))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          child: Column(children: [
                                            Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    // height:50,
                                                    margin: const EdgeInsets.only(bottom: 10),
                                                    child: TextFormField(
                                                      focusNode: _accountFocus,
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
                                                          prefixIcon:
                                                          const Icon(Icons.password),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.blue.shade400,
                                                                  width: 1)),
                                                          border: const OutlineInputBorder(),
                                                          hintText: '账号',
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey.shade600)),
                                                    ),
                                                  ),
                                                  Container(
                                                    // height:55,
                                                    margin: const EdgeInsets.only(bottom: 10),
                                                    child: TextFormField(
                                                      focusNode: _phoneFocus,
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
                                                          prefixIcon:
                                                          const Icon(Icons.password),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.blue.shade400,
                                                                  width: 1)),
                                                          border: const OutlineInputBorder(),
                                                          hintText: '手机号码',
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey.shade600)),
                                                    ),
                                                  ),
                                                  Container(
                                                    // height:70,
                                                    child: TextFormField(
                                                      obscureText: true,
                                                      controller: _passwordEditController,
                                                      focusNode: _passwordFocus,
                                                      validator: (value) {
                                                        String pattern =
                                                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                                                        if (value!.length < 8 ){
                                                          return '密码至少需要8位';
                                                        }
                                                        if (!_matchPattern(pattern, value)) {
                                                          return "必须包含大写字母，小写字母，数字和特殊字符";
                                                        } else if (value == ""){
                                                          return "密码不能为空";
                                                        } else  {
                                                          return null;
                                                        }
                                                      },
                                                      maxLength: 16,
                                                      decoration: InputDecoration(
                                                          prefixIcon:
                                                          const Icon(Icons.password),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.blue.shade400,
                                                                  width: 1)),
                                                          border: const OutlineInputBorder(),
                                                          hintText: '密码',
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey.shade600)),
                                                    ),
                                                  ),
                                                  Container(
                                                    // height:70,
                                                    child: TextFormField(
                                                      obscureText: true,
                                                      focusNode: _nextPasswordFocus,
                                                      maxLength: 16,
                                                      validator: (value) {
                                                        if (_passwordEditController.text != value) {
                                                          return '两次输入不同';
                                                        } else if (_passwordEditController.text == ""){
                                                          return '密码不能为空';
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                      decoration: InputDecoration(
                                                          prefixIcon: const Icon(
                                                              Icons.confirmation_num),
                                                          enabledBorder: OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors.blue.shade400,
                                                                  width: 1)),
                                                          border: const OutlineInputBorder(),
                                                          hintText: '再次确认密码',
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey.shade600)),
                                                    ),
                                                  ),
                                                  Container(
                                                    // height:50,
                                                    child: TextField(
                                                      decoration: InputDecoration(
                                                          suffixIcon: Padding(
                                                            padding: const EdgeInsets.all(5),
                                                            child: MaterialButton(
                                                                onPressed: ()  async{

                                                                  _buttonClickListen();
                                                                },
                                                                textColor: _isButtonEnable
                                                                    ? Colors.black
                                                                    : Colors.grey,
                                                                child: Text(buttonText)),
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors.blue.shade400,
                                                                width: 1),
                                                          ),
                                                          border: const OutlineInputBorder(),
                                                          hintText: '手机验证码',
                                                          hintStyle: TextStyle(
                                                              color: Colors.grey.shade600
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Container(
                                                    // height:50,
                                                    margin: const EdgeInsets.only(bottom: 10),
                                                    child: MyCode(),
                                                    // child: TextFormField(
                                                    //   focusNode: _accountFocus,
                                                    //   validator: (value) {
                                                    //     if (value!.length > 20) {
                                                    //       return '账号名称长度不能超过20个字符';
                                                    //     }
                                                    //     if (value == "" || value == null) {
                                                    //       return '账号不能为空';
                                                    //     } else {
                                                    //       return null;
                                                    //     }
                                                    //   },
                                                    //   decoration: InputDecoration(
                                                    //       prefixIcon:
                                                    //       const Icon(Icons.password),
                                                    //       enabledBorder: OutlineInputBorder(
                                                    //           borderSide: BorderSide(
                                                    //               color: Colors.blue.shade400,
                                                    //               width: 1)),
                                                    //       border: const OutlineInputBorder(),
                                                    //       hintText: '账号',
                                                    //       hintStyle: TextStyle(
                                                    //           color: Colors.grey.shade600)),
                                                    // ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  top: 15, bottom: 15),
                                              height: MediaQuery.of(context).size.height *
                                                  0.85 *
                                                  0.09,
                                              width: MediaQuery.of(context).size.width *
                                                  0.85 *
                                                  0.8,
                                              child: TextButton(
                                                  onPressed: () {
                                                    _checkForReturn(context);
                                                  },
                                                  style: ButtonStyle(
                                                    foregroundColor:
                                                    MaterialStateProperty.resolveWith(
                                                            (states) {
                                                          if (states.contains(
                                                              MaterialState.pressed)) {
                                                            return Colors.blue;
                                                          } else {
                                                            return Colors.white;
                                                          }
                                                        }),
                                                    backgroundColor:
                                                    MaterialStateProperty.resolveWith(
                                                            (states) {
                                                          if (states.contains(
                                                              MaterialState.pressed)) {
                                                            return Colors.blue.shade100;
                                                          } else {
                                                            return Colors.blue.shade400;
                                                          }
                                                        }),
                                                    shape: MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                          BorderRadius.circular(10)),
                                                    ),
                                                  ),
                                                  child: const Text('确认',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          letterSpacing: 10))),
                                            ),
                                          ]),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
            )
          ),
        );
  }

  bool _matchPattern(String pattern, String src) {
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(src);
  }

  _lostAllFocus() {
    _accountFocus.unfocus();
    _phoneFocus.unfocus();
    _passwordFocus.unfocus();
    _nextPasswordFocus.unfocus();
    _checkCodeFocus.unfocus();
  }

  void _checkForReturn(context) {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
    }
  }
}
