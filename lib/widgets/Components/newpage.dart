import 'package:flutter/material.dart';

class newpage extends StatelessWidget {
  final String title;
  final String content;

  const newpage({Key? key, required this.title, required this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [Text('联系方式：'),Text('QQ:941579288'),Text('MAIL:jbsteven79@gmail.com'),
              ElevatedButton(
                  onPressed: Navigator.of(context).pop, child: const Text('返回'))
            ],
          ),
        ),
      ),
    );
  }
}