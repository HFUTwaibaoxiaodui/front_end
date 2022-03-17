import 'package:flutter/material.dart';

import '../main.dart';
import '../widgets/order_detail.dart';

final _routes = {
  '/': (context) => MyHomePage(title: '123123',),
  // '/register': (context) => RegisterPage(),
  '/order_detail': (context, {arguments}) => OrderDetail(order: arguments)
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