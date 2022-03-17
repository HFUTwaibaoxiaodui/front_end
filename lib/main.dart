import 'package:flutter/material.dart';
import 'package:frontend/personal/Personal.dart';

import 'MissingKey/FixKey.dart';
import 'PersonManager/People.dart';
import 'PersonalCenter/Personal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PeoplesPage()
    );
  }
}



