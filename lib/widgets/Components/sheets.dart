import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

import 'Search.dart';
import 'newpageButton.dart';
import 'newpageTap.dart';

class SheetsPageWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SheetsPageWidgetState();
  }
}
class SheetsPageWidgetState extends State<SheetsPageWidget>{

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[ //searchbar 右侧的图标
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: (){
                showSearch(context: context, delegate: searchBarDelegate());
              },
            )
          ],
          title: Row(
            children: <Widget>[
              Expanded(
                child: TabBar(
                  tabs: <Widget>[
                    Tab(text: "待抢单"),
                    Tab(text: "待完成"),
                    Tab(text: "已完成"),
                  ],
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Scrollbar(
              child: Center(
                  child: ListView.builder(
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index)=>dislist(index,context),
                  )
              ),
            ),
            Scrollbar(
              child: Center(
                  child: ListView.builder(
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index)=>dislist(index,context),
                  )
              ),
            ),
            Scrollbar(
              child: Center(
                  child: ListView.builder(
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index)=>dislist(index,context),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}
Widget dislist(index,context) => Dismissible(
  key: UniqueKey(),
  child: liststart(index,context),
  background: dismissBackground(),
  direction: DismissDirection.endToStart,
  confirmDismiss: (DismissDirection direction) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("确认操作"),
          content: const Text("确定删除吗?"),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text("删除")
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("取消"),
            ),
          ],
        );
      },
    );
  },
);

dismissBackground(){
  return Container( color: Colors.red,
      child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: const <Widget>[
                    Icon(Icons.delete_forever, color: Colors.white, size: 18.0),
                    SizedBox(height: 5.0),
                    Text('Delete', style: TextStyle(color: Colors.white))
                  ]
              )
          )
      )
  );
}
getTimeStr() {
  var now = DateTime.now();
  var format = [yyyy, '-', mm, '-', dd, " ", HH, ":", mm, ":", ss];
  //打印时间 格式
  var time = formatDate(now, format);
  return time;
}
liststart(index,context){
  return Container(
    margin: const EdgeInsets.only(right: 20, left: 10),
    child: InkWell(
      onTap: (){Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => newpageTap(title: index.toString(), content: index)
          ));
      },
      child: Column(
        children: [SizedBox(height: 20),
          Row(
            children: [
              Row(
                  children:[CircleAvatar(
                      radius: 27,
                      backgroundImage: NetworkImage('https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fnews.yzz.cn%2Fpublic%2Fimages%2F110111%2F68_102448_4abb2_lit.jpg&refer=http%3A%2F%2Fnews.yzz.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1649250305&t=6a671e69a69338ae3c36edec77b2907d')
                  ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LimitedBox(
                            maxWidth:175,
                            child: Text('工大软工实训NO.$index组',maxLines: 1,overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w900))
                        ),
                        SizedBox(height: 20),
                        LimitedBox(
                            maxWidth:115,
                            child: Text('[HFUT]软工实训第$index组',maxLines: 1,overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500))
                        ),
                      ],
                    )]
              ),
              Expanded(
                child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(getTimeStr()),
                    ElevatedButton(
                        onPressed: (){Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => newpageButton(title: index.toString(), content: index)
                            ));
                        },
                        child: Text('接单')
                    ),
                  ],
                )
                ,
              )
            ],
          ),
          SizedBox(height: 20),
          Divider(height: 1)
        ],
      ),
    ),
  );
}
