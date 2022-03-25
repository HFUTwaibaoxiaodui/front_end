import 'package:flutter/material.dart';
import 'package:frontend/global/user_info.dart';
import 'package:frontend/pages/homepage/Home_Page.dart';
import 'package:frontend/pages/homepage/Page.dart';
import 'package:frontend/pages/login/loginPage.dart';
import 'package:frontend/pages/login/welcomePage.dart';
import 'package:frontend/views/create_work_order.dart';
import 'package:frontend/views/edit_work_order.dart';
import 'package:provider/provider.dart';
import 'global/routers.dart';

void main() {

  runApp(ChangeNotifierProvider<UserInfo>.value(
    value: UserInfo(),//1
    child: const MyApp(),
  ));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '机房',
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      // home:LoginPage(),
      home: CreateOrder(),
      // home:EditOrder(id: 1,),
    );
  }
}