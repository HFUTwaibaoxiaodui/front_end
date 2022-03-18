import 'package:flutter/material.dart';
import 'package:frontend/pages/register_page.dart';
import '../Components/bottomNavi.dart';
import '../pages/login_page.dart';


final _routes = {
  '/': (context, {arguments}) => LoginPage(userInfo: arguments),
  '/register': (context) => RegisterPage(),
  '/home': (context) => const BottomNavi()
import 'package:frontend/pages/exception_handle.dart';
import 'package:frontend/pages/exception_report.dart';
import 'package:frontend/pages/order_evaluate.dart';
import '../widgets/order_list.dart';
import '../widgets/order_detail.dart';

final _routes = {
  // '/': (context) => OrderListWidget(),
  '/exception_report' : (context, {arguments}) => ExceptionReport(id: arguments),
  '/order_evaluate': (context) => OrderEvaluate(),
  '/order_detail': (context, {arguments}) => OrderDetail(id: arguments)
};

Route createRoute(Widget widget) {
  return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(1.0, 0.0);
        var end = const Offset(0.0, 0.0);
        var tween = Tween(begin: begin, end: end);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      });
}

Route generateRoute(RouteSettings settings) {
  final String? name = settings.name;
  final Function? pageContentBuilder = _routes[name];
  if (settings.arguments != null) {
    final Route router = MaterialPageRoute(
        builder: (context) =>
            pageContentBuilder!(
                context,
                arguments: settings.arguments
            )
    );
    return router;
  } else {
    final Route router = MaterialPageRoute(
        builder: (context) => pageContentBuilder!(context));
    return router;
  }
}