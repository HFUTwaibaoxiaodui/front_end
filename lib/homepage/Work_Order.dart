import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/routes/order_detail.dart';

class WorkOrderPage extends StatefulWidget {
  @override
  createState() => _WorkOrderPage();
}
class _WorkOrderPage extends State<WorkOrderPage> {

  List<Widget> _list = [];
  @override
  void initState() {
    super.initState();
    // TODO: implement initState

  }

  @override
  Widget build(BuildContext context) {
    if(_list.isEmpty){

      _list.add(ListTile(
        title: Text(titleItems[0],style: TextStyle(
          fontSize: 20,
        ),),
      ),);
      _list.add(_setList(titleItems[1],'0',context));
      _list.add(_setList(titleItems[2],'0',context));
      _list.add(_setList(titleItems[3],'0',context));
      _list.add(ListTile(
        title: Text(titleItems[4],style: TextStyle(
          fontSize: 20,
        ),),
        // trailing: Icon(Icons.arrow_forward_ios_rounded),
      ),);
      _list.add(_setList(titleItems[5],'0',context));
      _list.add(_setList(titleItems[6],'0',context));
      _list.add(_setList(titleItems[7],'0',context));
      _list.add(_setList(titleItems[8],'0',context));
      _list.add(_setList(titleItems[9],'0',context));
      _list.add(_setList(titleItems[10],'0',context));
      _list.add(_setList(titleItems[11],'0',context));
      _list.add(_setList(titleItems[12],'0',context));
      _list.add(_setList(titleItems[13],'0',context));
      _list.add(_setList(titleItems[14],'0',context));
      _list.add(_setList(titleItems[15],'0',context));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("工单视图"),
      ),
      body: new Scrollbar(
        child:ListView.builder(
          itemCount: titleItems.length,
          // itemExtent:50,
          itemBuilder: (BuildContext context,item){
            return new Container(
              child: new Column(
                children: <Widget>[
                  _list[item],
                  new Divider()
                ],
              ),
            );
            // return _list[index];

          },

        ),
      ),

    );
  }
  Widget LitemWidget(String index){
    return ListTile(
      // leading: Icon(Icons.favorite_border),
      title: Text(index,style: TextStyle(
        fontSize: 20,
      ),),
      // trailing: Icon(Icons.arrow_forward_ios_rounded),
    );
  }
  Widget itemWidget(String index){
    return ListTile(
      // leading: Icon(Icons.favorite_border),
      title: Text('$index',style: TextStyle(
        fontSize: 16,
      ),),
      contentPadding: EdgeInsets.only(left: 30),
      trailing: Icon(Icons.arrow_forward_ios_rounded),
      onTap: (){
      },
    );
  }

  // 数据源
  List<String> titleItems = <String>[
    '我的工单','我创建的工单', '我负责的工单', '我协调的工单',
    '工单视图', '所有工单',
    '今日新建工单', '今日已关闭工单',
    '待受理工单', '待分配工单',
    '待派工的工单', '待服务的工单',
    '待回访的工单', '已关闭的工单',
    '已取消的工单','异常工单',
  ];

  _onTap(BuildContext context){
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DetailPage();
    }));
  }

  Widget _setList(String list,String count,BuildContext context){
   return Container(
     height: 50,
      margin: EdgeInsets.only(left: 30),
      child: InkWell(
        onTap:()=>_onTap(context),
        child: Row(
          children: [
            Text(list,style: TextStyle(
              fontSize: 16,
            ),),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Positioned(
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: BoxConstraints(
                        minHeight: 12,
                        minWidth: 12,
                      ),
                      child: Text(
                        count,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }


}