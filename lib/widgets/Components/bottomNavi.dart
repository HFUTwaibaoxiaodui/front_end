import 'package:flutter/material.dart';
import 'homepage.dart';
import 'sheets.dart';
import 'myInfo.dart';
class BottomNavi extends StatefulWidget{
  const BottomNavi({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BottomNaviState();
  }
}
class BottomNaviState extends State<BottomNavi>{
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: '首页'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.description,
              ),
              label: '工单'
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.mood,
              ),
              label: '我的'
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (int i) {
          setState(() {
            _currentIndex = i;
          });
        },
      ),
      body: pages[_currentIndex],
    );

  }

}
List pages = [const MyHomePage(),SheetsPageWidget(),MyPageWidget()];
