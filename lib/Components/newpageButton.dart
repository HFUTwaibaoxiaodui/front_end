import 'package:flutter/material.dart';

class newpageButton extends StatelessWidget {
  final String title;
  final int content;

  const newpageButton({Key? key, required this.title, required this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [Text('这是通过点击第$content项的按钮跳转的页面'),
              ElevatedButton(
                  onPressed: Navigator.of(context).pop, child: const Text('返回'))
            ],
          ),
        ),
      ),
    );
  }
}