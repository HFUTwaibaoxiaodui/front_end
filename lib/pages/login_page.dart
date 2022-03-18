import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:frontend/animation/login_animation_background.dart';
import 'package:frontend/pages/register_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global/routers.dart';

class LoginPage extends StatefulWidget {

  final Map<String, dynamic>? userInfo;

  LoginPage({Key? key, required this.userInfo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>  with SingleTickerProviderStateMixin {

  late bool _passwordVisible;
  late FocusNode _passwordFocusNode;
  late FocusNode _accountFocusNode;
  late AnimationController _animationController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _passwordFocusNode = FocusNode();
    _accountFocusNode = FocusNode();
    _animationController = AnimationController(
        lowerBound: -1.0,
        upperBound: 1.0,
        duration: const Duration(seconds: 5),
        value: 0.0,
        vsync: this);

    _animationController.repeat();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _accountFocusNode.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){_lostAllFocus();},
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                child: Center(
                  child: Column(
                    children: [
                      AnimatedBuilder(animation: _animationController, builder: (context, child) {
                        return ClipPath(
                          clipper: CustomHeaderClipPath(_animationController.value),
                          child: _buildContainer(context),
                        );
                      }
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.blueAccent,
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10)
                                    ),
                                  ]
                              ),
                              child: Column (
                                  children: [
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            child: TextFormField(
                                              focusNode: _accountFocusNode,
                                              validator: (value) {
                                                if (value == "" || value == null) {
                                                  return '账号不能为空';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                      borderSide: BorderSide(
                                                          color: Colors.blue.shade200,
                                                          width: 1
                                                      )
                                                  ),
                                                  border: const OutlineInputBorder(),
                                                  prefixIcon: const Icon(Icons.person),
                                                  hintText: '账号',
                                                  hintStyle: TextStyle(color: Colors.grey.shade600)
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(8),
                                            child: TextFormField(
                                              focusNode: _passwordFocusNode,
                                              validator: (value) {
                                                if (value == "" || value == null) {
                                                  return '密码不能为空';
                                                } else {
                                                  return null;
                                                }
                                              },
                                              obscureText: !_passwordVisible,
                                              decoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(20),
                                                      borderSide: BorderSide(
                                                          color: Colors.blue.shade400,
                                                          width: 1
                                                      )
                                                  ),
                                                  prefixIcon: const Icon(Icons.password),
                                                  suffixIcon: IconButton(
                                                    icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                                                    onPressed: () {setState(() {
                                                      _passwordFocusNode.unfocus();
                                                      _passwordVisible = !_passwordVisible;
                                                    });},
                                                  ),
                                                  border: const OutlineInputBorder(),
                                                  hintText: '密码',
                                                  hintStyle: TextStyle(color: Colors.grey.shade600)
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 15, bottom: 15),
                                      height: MediaQuery.of(context).size.height * 0.85 * 0.09,
                                      width: MediaQuery.of(context).size.width * 0.85 * 0.8,
                                      child: TextButton(
                                          onPressed: () {_tryLogin(context);},
                                          style: ButtonStyle(
                                            foregroundColor:MaterialStateProperty.resolveWith((states){
                                              if (states.contains(MaterialState.pressed)) {
                                                return Colors.blue;
                                              } else {
                                                return Colors.white;
                                              }
                                            }),
                                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                                              if (states.contains(MaterialState.pressed)) {
                                                return Colors.blue.shade100;
                                              } else {
                                                return Colors.blue.shade400;
                                              }
                                            }),
                                            shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10)),
                                            ),
                                          ),
                                          child: const Text('登录', style: TextStyle(fontSize: 18, letterSpacing: 10))
                                      ),
                                    ),
                                    SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.85 * 0.1,
                                        child: RichText(
                                          text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: '注册',
                                                  style: const TextStyle(color: Colors.blue),
                                                  recognizer: TapGestureRecognizer()..onTap = () {
                                                    Navigator.of(context).push(createRoute(RegisterPage()));
                                                  },
                                                )
                                              ]
                                          ),
                                        )
                                    )
                                  ]
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }

  _tryLogin(context) {
    _lostAllFocus();
    if (_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "验证成功",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 12.0
      );
      Navigator.of(context).pushNamed('/home');
    }
  }

  _lostAllFocus() {
    _passwordFocusNode.unfocus();
    _accountFocusNode.unfocus();
  }

  Container _buildContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.34,
      child: const LoginAnimationBackground(),
    );
  }
}

class CustomHeaderClipPath extends CustomClipper<Path> {
  double progress;

  CustomHeaderClipPath(this.progress);

  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.8);

    double controllerCenterX =
        size.width * 0.5 + (size.width * 0.6 + 1) * sin(progress * pi);
    double controllerCenterY = size.width * 0.7 + 50 * cos(progress * pi);

    path.quadraticBezierTo(
        controllerCenterX, controllerCenterY, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}