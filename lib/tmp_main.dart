import 'package:flutter/material.dart';
import 'package:frontend/pages/homepage/Page.dart';
import 'package:frontend/pages/login/welcomePage.dart';
import 'global/routers.dart';

void main() {
  runApp(const MyApp());
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