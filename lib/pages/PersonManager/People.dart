import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/global/const.dart';

import 'IndexBar.dart';
import 'PeopleDitails.dart';
import 'SearchPage.dart';
import 'friends_data.dart';

class PeoplesPage extends StatefulWidget {



  _PeoplesPageState createState() => _PeoplesPageState();
}
Dio dio =Dio();
class _PeoplesPageState extends State<PeoplesPage> {
//  字典里面放item和高度的对应数据
  final Map _groupOffsetMap = {
//    这里因为根据实际数据变化和固定全部字母前两个值都是一样的，所以没有做动态修改，如果不一样记得要修改
    INDEX_WORDS[0]: 0.0,
    INDEX_WORDS[1]: 0.0,
  };

  late ScrollController _scrollController;

  final List<Friends> _listDatas = [];

  late List<dynamic> list;

  getinfo() async {
  Response response = await dio.get('http://121.40.130.17:9090/account/selectAllInformation');
  print(response.data);
  list=response.data;
  for (var element in list) {
    _listDatas.add(Friends(
      imageUrl:'https://randomuser.me/api/portraits/women/17.jpg' ,
      name: element['realName'],
      indexLetter:element['firstLetter']
    ));
    _listDatas.sort((Friends a, Friends b) {
      return a.indexLetter!.compareTo(b.indexLetter!);
    });
    var _groupOffset = 54.5 * 4;
//经过循环计算，将每一个头的位置算出来，放入字典
    for (int i = 0; i < _listDatas.length; i++) {
      if (i < 1 || _listDatas[i].indexLetter != _listDatas[i - 1].indexLetter) {
        //第一个cell
        _groupOffsetMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        //保存完了再加——groupOffset偏移
        _groupOffset += 84.5;
      } else {
//        if (_listDatas[i].indexLetter == _listDatas[i - 1].indexLetter) {
        //此时没有头部，只需要加偏移量就好了
        _groupOffset += 54.5;
      }
    }
  }
  print(_listDatas);
}
  @override
  void initState(){
    getinfo();
    super.initState();

    //排序!

    _scrollController = ScrollController();
  }
  // _getData() async{
  //   Response response;
  //   var apiUrl="";
  //   Response result=await Dio().get(apiUrl);
  //   // print(json.decode(result.data)["result"]);
  //   setState(() {
  //     this._list=json.decode(result.data)["result"];
  //   });
  // }

  final List<Friends> _headerData = [
    Friends(imageUrl: 'assets/images/新的朋友.png', name: '添加人员'),
    Friends(imageUrl: 'assets/images/群聊.png', name: '部门'),
    Friends(imageUrl: 'assets/images/标签.png', name: '收藏'),
    Friends(imageUrl: 'assets/images/公众号.png', name: '群组'),
  ];

  Widget _itemForRow(BuildContext context, int index) {
//    系统cell
    if (index < _headerData.length) {
      return _FriendsCell(
        imageAssets: _headerData[index].imageUrl!,
        name: _headerData[index].name!,
      );
    }
    //显示剩下的cell
    //如果当前和上一个cell的indexLetter一样，就不显示
    bool _hideIndexLetter = (index - 4 > 0 &&
        _listDatas[index - 4].indexLetter == _listDatas[index - 5].indexLetter);
    return _FriendsCell(
      imageUrl: _listDatas[index - 4].imageUrl!,
      name: _listDatas[index - 4].name!,
      groupTitle: _hideIndexLetter ? 'null' : _listDatas[index - 4].indexLetter!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('人员管理',style: TextStyle(fontSize: 14),),
        actions: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: IconButton (
                icon:Icon(Icons.search),
                tooltip:'搜索',
                onPressed:(){
                  showSearch(context: context,delegate: SearchBarDelegate());
                },),
            ),
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (BuildContext context) => DiscoverChildPage(
              //       title: '添加朋友',
              //     )));
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
              color: WeChatThemColor,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _listDatas.length + _headerData.length,
                itemBuilder: _itemForRow,
              )), //列表
          IndexBar(
            indexBarCallBack: (String str) {
              if (_groupOffsetMap[str] != null) {
                _scrollController.animateTo(_groupOffsetMap[str],
                    duration: Duration(milliseconds: 1), curve: Curves.easeIn);
              }
            },
          ), //悬浮检索控件
        ],
      ),
    );
  }
}

class _FriendsCell extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String? groupTitle;
  final String? imageAssets;

  const _FriendsCell(
      {this.imageUrl, required this.name, this.imageAssets, this.groupTitle}); //首字母大写

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(left: 10),
          height: groupTitle != null ? 30 : 0,
          color: Color.fromRGBO(1, 1, 1, 0.0),
          child: groupTitle != null
              ? Text(
            groupTitle ?? 'null',
            style: TextStyle(fontSize: 13, color: Colors.grey),
          )
              : null,
        ), //组头
        Material(
          color: Colors.white,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              print('点击了');
              Navigator.of(context).push(
                  CupertinoPageRoute(builder: (BuildContext context){return PeopleDitails();})
              );
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10),
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      image: DecorationImage(
                        image: _getImage(),
                      )),
                ), //图片
                Container(
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 12),
                  ),
                ), //昵称
                Container(

                ),
              ],
            ),
          ),
        ), //通讯录组内容
        Container(
          height: 0.5,
          color: WeChatThemColor,
          child: Row(
            children: <Widget>[
              Container(
                width: 50,
                color: Colors.white,
              )
            ],
          ),
        ) //分割线
      ],
    );
  }

    _getImage() {
    if (imageUrl != null) {
      return NetworkImage(imageUrl!);
    } else {
      return AssetImage(imageAssets!);
    }
  }
}