import 'package:flutter/material.dart';
import 'package:frontend/widgets/operation.dart';
import 'package:frontend/widgets/order.dart';
import 'package:frontend/widgets/order_card.dart';
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widgets. It takes a single child and positions it
        // in the middle of the parent.
        child: Container(
          child: ListView(
            children: [
              OrderCard (
                order: Order(
                  orderTitle: '修理煤气灶',
                  creatorName: '李四',
                  orderAddress: '安徽省合肥市蜀山区合肥工业大学翡翠湖校区科教楼B301的804机房',
                  createTime: '2022-03-12',
                  orderCode: 'O202203120001',
                  orderState: '待抢单',
                  phoneNum: '13956190211',
                  operationList: [
                    Operation(
                        operationName: '服务',
                        description: '123131231321',
                        operationTime: '2022-01-11 09:30:01'
                    ),
                    Operation(
                        operationName: '服务',
                        description: '123131231321',
                        operationTime: '2022-01-11 09:30:01'
                    ),
                    Operation(
                      operationName: '服务',
                      description: '123131231321',
                      operationTime: '2022-01-11 09:30:01'
                    ),
                    Operation(
                      operationName: '抢单',
                      description: '123131231321',
                      operationTime: '2022-01-11 09:30:01'
                    ),
                    Operation(
                      operationName: '新建',
                      description: '123131231321',
                      operationTime: '2022-01-11 09:30:01'
                    )
                  ]
                ),
              ),
              OrderCard (
                order: Order(
                    orderTitle: '修理的电饭煲',
                    creatorName: '李物',
                    orderAddress: '安徽省合肥市蜀山区合肥工业大学翡翠湖校区科教楼B301的802机房',
                    createTime: '2022-03-11',
                    orderCode: 'O202203120002',
                    orderState: '待服务',
                    phoneNum: '13956190212'
                ),
              ),
              OrderCard (
                order: Order(
                    orderTitle: '修理的高压煲',
                    creatorName: '王物',
                    orderAddress: '安徽省合肥市蜀山区合肥工业大学翡翠湖校区科教楼B301的802机房',
                    createTime: '2022-03-11',
                    orderCode: 'O202203120003',
                    orderState: '异常',
                    phoneNum: '13956190212'
                ),
              ),
            ],
          )
        )
      ),
      // body: ExceptionReport(),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
