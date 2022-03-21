import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';



class FixKey extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                FocusManager.instance.primaryFocus!.unfocus();
              }
            },
            child: FixKeyPage(),
          ),
        ),
    );
  }
}

class FixKeyPage extends StatefulWidget {
  @override
  _FixKeyPageState createState() {
    // TODO: implement createState
    return _FixKeyPageState();
  }
}

class _FixKeyPageState extends State<FixKeyPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 120.0,
              alignment:Alignment.centerLeft,
              padding: EdgeInsets.only(left:15.0),
              color: Colors.white,
              child: Container(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed:(){
                        print('返回');
                      },
                    )
              ),
            ),
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left:30.0,right: 30.0),
              child: new Container(
                child: buildForm(),
              ),
            ),

          ],
        ),

      ],
    );
  }

  TextEditingController old_pwdController = new TextEditingController();
  TextEditingController new_pwdController = new TextEditingController();

  GlobalKey formKey = new GlobalKey<FormState>();


  Widget buildForm() {
    return Form(
      //设置globalKey，用于后面获取FormState
      key: formKey,
      //开启自动校验

      child: Column(
        children: <Widget>[
          TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              //键盘回车键的样式
              textInputAction: TextInputAction.next,
              controller: old_pwdController,
              decoration: InputDecoration(
                  labelText: "新密码", hintText: "请输入新密码", icon: Icon(Icons.lock)),
              obscureText: true,
//              校验密码
              validator: (v) {
                return v!.trim().length > 5 ? null : "密码不能少于6位";
              }),
          TextFormField(
              autofocus: false,
              controller: new_pwdController,
              decoration: InputDecoration(
                  labelText: "确认密码", hintText: "请再次输入新密码", icon: Icon(Icons.lock)),
              obscureText: true,
//              校验密码
              validator: (v) {
                return v!.trim().length > 5 ? null : "密码不能少于6位";
              }
              ),
          // 登录按钮
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text("提交"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      //在这里不能通过此方式获取FormState，context不对
                      //print(Form.of(context));
                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。

                      if ((formKey.currentState as FormState).validate()) {
                        //验证通过提交数据
                        EolToast.toast(context, "修改成功");
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

}

class EolToast {
  static OverlayEntry? overlayEntry;

  static final EolToast _showToast = EolToast._internal();
  factory EolToast() {
    return _showToast;
  }
  EolToast._internal();
  static toast(context, String str) {
    if (overlayEntry != null) return;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        top: MediaQuery.of(context).size.height * 0.8,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              constraints: BoxConstraints(
                minHeight: 50,
              ),
              child: Center(
                child: Text(
                  str,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      );
    });
    var overlayState = Overlay.of(context);
    overlayState!.insert(overlayEntry!);
    Future.delayed(Duration(seconds: 1), () {
      overlayEntry!.remove();
      overlayEntry = null;
    });
  }
}


