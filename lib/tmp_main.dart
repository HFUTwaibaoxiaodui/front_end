import 'package:flutter/material.dart';
import 'package:frontend/global/user_provider.dart';
import 'package:frontend/pages/homepage/Page.dart';
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
      home:IndexPage(),
    );
  }
}