import 'package:flutter/material.dart';
import 'homepage/Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '机房',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:IndexPage(),
    );
  }
}

