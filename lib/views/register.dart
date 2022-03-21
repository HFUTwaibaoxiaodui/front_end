import 'package:flutter/material.dart';
class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '设备注册'),
    );
  }
}
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  String userName = '';
  String passWord = '';
  String phoneNum = '';
  String realName = '';
  GlobalKey<FormState> formGlobalKey = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: buildHome(context),
    );
  }
  buildHome(context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(height: 20),
                Image.network('https://img2.baidu.com/it/u=1584167732,2110356106&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', width: 50, height: 50,
                    fit: BoxFit.cover),
                Text("注册",
                  style: TextStyle(
                    // color: Colors.red,
                    fontSize: 18,
                    letterSpacing: 1,
                    wordSpacing: 2,
                    height: 1.2,
                    fontWeight: FontWeight.w600
                  ),
                ),

                // Image.asset('assets/register.jpeg',
                //     width: 50, height: 50),
                SizedBox(height: 20),
              ],
            ),
          ),

          Expanded(
            child: Column(
              children: [
                // Row(
                //   children: [
                //     Container(
                //       padding: EdgeInsets.only(left: 20),
                //       width: 250,
                //       height: 50,
                //       child: TextFormField(
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                //           border: OutlineInputBorder(),
                //           labelStyle: TextStyle(fontSize: 16),
                //           labelText: '账户名称',
                //           hintText: '请输入你的账户名称',
                //           prefixIcon: Icon(Icons.supervised_user_circle),
                //           // prefix: Icon(Icons.phone_android),
                //           // icon: Icon(Icons.phone_android)
                //         ),
                //         // maxLength: 11,
                //         onSaved: (value) {
                //           this.userName = value!;
                //         },
                //         validator: (value) {
                //           if (value == null || value.length == 0) {
                //             return "请输入你的账户名称";
                //           }
                //           // else if (!RegExp(PHONE_REG).hasMatch(value)) {
                //           //   return "手机号错误，请重新输入";
                //           // }
                //           return null;
                //         },
                //       ),
                //     ),
                //     SizedBox(width: 20),
                //     _buildNumButton(context),
                //   ],
                // ),//账户名称
                // SizedBox(height: 20),
                // Row(
                //   children: [
                //     Container(
                //       width: 250,
                //       height: 50,
                //       padding: EdgeInsets.only(left: 20),
                //       child: TextFormField(
                //         obscureText: true, // 是否密码显示
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                //           border: OutlineInputBorder(),
                //           labelStyle: TextStyle(fontSize: 16),
                //           labelText: '密码',
                //           hintText: '请输入密码',
                //           prefixIcon: Icon(Icons.lock),
                //         ),
                //         onSaved: (value) {
                //           this.passWord = value!;
                //         },
                //         validator: (value) {
                //           if (value == null || value.length == 0) {
                //             return "请输入密码";
                //           } else if (value.length < 6) {
                //             return "密码最少6位";
                //           }
                //           return null;
                //         },
                //       ),
                //     ),
                //     SizedBox(width: 20),
                //     _buildBindButton(context),
                //   ],
                // ),//密码
                // SizedBox(height: 20),
                // Row(
                //   children: [
                //     Container(
                //       width: 250,
                //       height: 50,
                //       padding: EdgeInsets.only(left: 20),
                //       child: TextFormField(
                //         obscureText: true, // 是否密码显示
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                //           border: OutlineInputBorder(),
                //           labelStyle: TextStyle(fontSize: 16),
                //           labelText: '手机号',
                //           hintText: '请输入手机号',
                //           prefixIcon: Icon(Icons.lock),
                //         ),
                //         onSaved: (value) {
                //           this.phoneNum = value!;
                //         },
                //         validator: (value) {
                //           if (value == null || value.length == 0) {
                //             return "请输入手机号";
                //           } else if (value.length != 11) {
                //             return "手机号11位";
                //           }
                //           return null;
                //         },
                //       ),
                //     ),
                //     SizedBox(width: 20),
                //     _buildBindButton(context),
                //   ],
                // ),//手机号
                // SizedBox(height: 20),
                // Row(
                //   children: [
                //     Container(
                //       width: 250,
                //       height: 50,
                //       padding: EdgeInsets.only(left: 20),
                //       child: TextFormField(
                //         obscureText: true, // 是否密码显示
                //         decoration: InputDecoration(
                //           contentPadding: EdgeInsets.symmetric(vertical: 4.0),
                //           border: OutlineInputBorder(),
                //           labelStyle: TextStyle(fontSize: 16),
                //           labelText: '您的姓名',
                //           hintText: '请输入姓名',
                //           prefixIcon: Icon(Icons.lock),
                //         ),
                //         onSaved: (value) {
                //           this.realName = value!;
                //         },
                //         validator: (value) {
                //           if (value == null || value.length == 0) {
                //             return "请输入姓名";
                //           } else if (value.length < 1) {
                //             return "姓名最少两个字符";
                //           }
                //           return null;
                //         },
                //       ),
                //     ),
                //     SizedBox(width: 20),
                //     _buildBindButton(context),
                //   ],
                // ),//真实姓名

              ],
            ),
          ),

          // Spacer(),

        ],
      ),
    );
  }

  ElevatedButton _buildNumButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {},
      child: Container(
        width: 60,
        height: 50,
        child: TextButton(
          onPressed: null,
          child: Text(
            '确定',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildBindButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => {},
      child: Container(
        width: 60,
        height: 50,
        child: TextButton(
          onPressed: null,
          child: Text(
            '绑定',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _numPress(context) {
    print('numPressed');
  }
}

