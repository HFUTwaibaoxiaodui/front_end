import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => OrderDetailState();
}

class OrderDetailState extends State<OrderDetail> {   @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工单详情', style: TextStyle(color: Colors.white, fontSize: 20)),
        backgroundColor: Colors.cyanAccent.shade700,
        centerTitle: true,
        // 底部阴影
        elevation: 0.5,
        actions:[_buildPopUpList()],
      ),
      body: Container (
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey.shade300,
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: Row(

              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.52,
              margin: const EdgeInsets.only(bottom: 10),
              color: Colors.white,
              child: Row(

              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10, left: 10, top: 5, bottom: 5),
              height: MediaQuery.of(context).size.height * 0.06,
              child: Center (
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: (){},
                        child: const Text('123213'),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      color: Colors.cyanAccent.shade700,
                      child: GestureDetector(
                        onTap: (){},
                        child: const Text('123213'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}


Widget _buildPopUpList() {
  return PopupMenuButton<String>(
    itemBuilder: (context) => <PopupMenuEntry<String>>[
      PopupMenuItem<String>(
        value: '语文',
        child: const Text('语文'),
      ),
      PopupMenuItem<String>(
        value: '数学',
        child: const Text('数学'),
      ),
      PopupMenuItem<String>(
        value: '英语',
        child: const Text('英语'),
      ),
      PopupMenuItem<String>(
        value: '物理',
        child: const Text('物理'),
      ),
    ]
  );
}