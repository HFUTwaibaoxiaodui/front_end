import 'package:flutter/material.dart';
import 'package:frontend/util/android_activity_visitor.dart';

class InitMap extends StatefulWidget {
  const InitMap({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InitMapState();
}

class _InitMapState extends State<InitMap> {
  String? title;
  double? distance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('地图'),
      ),
      body: ListView(
        children: [
          ListTile(title: TextButton(
            onPressed: () {
              AndroidActivityVisitor.getDistance().then((value){
                setState(() {
                  distance = value;
                });
              });
            },
            child: const Text('获取距离'),
          ),
            subtitle: Text(distance == null ? 'null' : distance!.toString()),
          ),
          ListTile(title: TextButton(
            onPressed: () {
              AndroidActivityVisitor.pickAddress().then((value){
                setState(() {
                  title = value['address'];
                  print(value);
                });
              });
            },
            child: const Text('跳转1'),
          )),
          ListTile(title: Text(title ?? 'null'))
        ],
      ),
    );
  }
}