import 'package:flutter/material.dart';
import 'package:frontend/pages/exception_report.dart';
import 'package:frontend/pages/order_evaluate.dart';
import '../widgets/order_detail.dart';


final _routes = {
  // '/': (context) => OrderListWidget(),
  // '/': (context, {arguments}) => LoginPage(userInfo: arguments),
  // '/register': (context) => RegisterPage(),
  // '/home': (context) => IndexPage(),
  '/exception_report' : (context, {arguments}) => ExceptionReport(id: arguments),
  '/order_evaluate': (context, {arguments}) => OrderEvaluate(id: arguments['id'], name: arguments['name']),
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