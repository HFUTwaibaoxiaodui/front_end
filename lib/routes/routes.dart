import 'package:flutter/material.dart';
import 'package:frontend/routes/today_work.dart';

final routes = {
  // '/cateGroyHomePage': (context, {arguments}) =>
  //     CateGroyHomePage(arguments: arguments),
  // '/settingHomePage': (context) => SettingHomePage(),
  // '/login':(context)=>CartPage(),
  // '/registerFirst':(context)=>RegisterFirstPage(),
  // '/registerSecond':(context)=>RegisterSecondPage(),
  // '/registerThird':(context)=>RegisterThirdPage(),
  "/today":(context) => TodayPage(),
  // "/B":(context , {arguments}) => BPage(arguments: arguments),
  // "/C":(context , {arguments}) => CPage(arguments: arguments),
  // "/D":(context , {arguments}) => HomePage(),
};

var onGenerareRoute = (RouteSettings settings) {
  //String? 表示 name 为可空类型
  final String? name = settings.name;
  //Function? 表示 pageContentBuilder 为可空类型
  final Function? pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
