import 'package:flutter/material.dart';
import 'package:frontend/global/back_end_interface_url.dart';
import 'package:frontend/util/debug_print.dart';
import 'package:frontend/util/net/network_util.dart';
import 'package:frontend/widgets/operation.dart';
import 'package:frontend/widgets/order.dart';
import 'package:frontend/widgets/order_card.dart';
import 'global/future_build.dart';
import 'global/routers.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widgets is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: generateRoute,
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '123')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widgets is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widgets) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  late Future _orderList;

  @override
  void initState() {
    super.initState();
    _orderList = _getOrderList();
  }

  Future _getOrderList() async {
    printWithDebug(getAllOrders);
    List<Order> _orderList = [];
    List orders = await HttpManager().get(getAllOrders);
    for (var element in orders) {
      setState(() {
        _orderList.add(Order.fromJson(element));
      });
    }

    return _orderList;
  }

  Widget _buildOrderList(List<Order> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        return OrderCard(order: list[index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: buildFutureBuilder(
          buildWidgetBody: _buildOrderList,
          future: _orderList
        ),
      ),
    );
  }
}
