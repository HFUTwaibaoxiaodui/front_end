import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ListViewPage extends StatefulWidget {
  @override
  createState() => new ListViewState();
}

class ListViewState extends State<ListViewPage> {

  List<Widget> _list = [];
  bool testData = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < titleItems.length-2; i++) {
      _list.add(buildListData(context, titleItems[i], imagesItems[i], subTitleItems[i]));
    }
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body:
        new RefreshIndicator(
          child:new Scrollbar(
            child: new ListView.builder(
              // reverse: true,
              itemBuilder: (context, item) {
                final test = _list[item].toString();
                return new Dismissible(
                  key: Key(test),
                  onDismissed: (direction) {
                    _list.removeAt(item);
                  },

                  secondaryBackground: Container(
                    child: Text('左滑删除',style: TextStyle(color: Colors.white),),
                    color: Colors.red,
                    padding: EdgeInsets.only(right: 30),
                    alignment: Alignment.centerRight,
                  ),

                  background: Container(
                    child: Text('右滑删除',style: TextStyle(color: Colors.white),),
                    color: Colors.yellow,
                    padding: EdgeInsets.only(right: 30),
                    alignment: Alignment.centerLeft,
                  ),


                  child:new Container(
                    child: new Column(
                      children: <Widget>[
                        buildListData(context, titleItems[item], imagesItems[item], subTitleItems[item]),
                        new Divider()
                      ],
                    ),
                  ),
                );
              },
              itemCount:_list.length,
            ),

          ),
          onRefresh: _handleRefresh,
        ),



    );
  }

  Widget buildListData(BuildContext context, String titleItem, Image iconItem, String subTitleItem) {
    return new ListTile(
      leading: iconItem,
      title: new Text(
        titleItem,
        style: TextStyle(fontSize: 18),
      ),
      subtitle: new Text(
        subTitleItem,
      ),
      trailing: Column(
          children:[
            Text('2022/3/27 18:00',
              style: TextStyle(fontSize: 16),),
            SizedBox(
              width: 70,
              height: 30,
              child:ElevatedButton(
                onPressed: (){
                 },
                child: Text('跳转'),
              ),),


          ]

      ),


      onTap: () {

      },

    );
  }

  // 数据源
  List<String> titleItems = <String>[

    'girl（1）', 'girl（2）',
    'girl（3）', 'girl（4）',
    'girl（5）', 'girl（6）',
    'girl（7）', 'girl（8）',
    'girl（9）', 'girl（10）',
    'girl（11）', 'girl（12）',
    'girl(13)', 'girl(14)',
  ];

  List<Icon> iconItems = <Icon>[
    new Icon(Icons.keyboard), new Icon(Icons.print),
    new Icon(Icons.router), new Icon(Icons.pages),
    new Icon(Icons.zoom_out_map), new Icon(Icons.zoom_out),
    new Icon(Icons.youtube_searched_for), new Icon(Icons.wifi_tethering),
    new Icon(Icons.wifi_lock), new Icon(Icons.widgets),
    new Icon(Icons.weekend), new Icon(Icons.web),
    new Icon(Icons.accessible), new Icon(Icons.ac_unit),
  ];
  List<Image> imagesItems = <Image>[
    new Image.asset('images/girl.jpg'),new Image.asset('images/girl2.jpeg'),
    new Image.asset('images/girl.jpg'),new Image.asset('images/girl2.jpeg'),
    new Image.asset('images/girl.jpg'),new Image.asset('images/girl2.jpeg'),
    new Image.asset('images/girl.jpg'),new Image.asset('images/girl2.jpeg'),
    new Image.asset('images/girl.jpg'),new Image.asset('images/girl2.jpeg'),
    new Image.asset('images/girl.jpg'),new Image.asset('images/girl2.jpeg'),
    new Image.asset('images/girl.jpg'),new Image.asset('images/girl2.jpeg'),
  ];

  List<String> subTitleItems = <String>[
    'player: skier', 'player: skier',
    'player: beautiful', 'player: bright',
    'player: clever', 'player: talented',
    'player: gifted', 'player: favored',
    'player: skier', 'player: skier',
    'player: skier', 'player: skier',
    'player: skier', 'player: skier',
  ];
  Future<Null>  _handleRefresh() async {

    // 延迟3秒后添加新数据， 模拟网络加载
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        if(testData == true){
          _list = [];
          // List<Widget> newlist = [];
          for (int i = 0; i < _list.length ; i++) {
            _list.add(buildListData(context, titleItems[i], imagesItems[i], subTitleItems[i]));
          //  newList.add(buildListData(context, titleItems[i], imagesItems[i], subTitleItems[i]));
          }
          // print("**************${_list.length}==="+_list.length.toString());
          // testData = false;
        }

      });
    });
  }


}
