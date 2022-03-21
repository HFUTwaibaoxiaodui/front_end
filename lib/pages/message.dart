import 'package:flutter/material.dart';
import 'package:frontend/global/theme.dart';
import 'package:date_format/date_format.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);
  @override
  _Messagepage createState() => _Messagepage();
}
class _Messagepage extends State<MessagePage>{
  Widget _singleMessage(index,context){
      return Container(
        margin: const EdgeInsets.only(right: 20, left: 10),
        child: InkWell(
          onTap: (){
          },
          child: Column(
            children: [SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child:Row(
                      children:[
                        CircleAvatar(
                          radius: 27,
                          backgroundImage: NetworkImage('https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fnews.yzz.cn%2Fpublic%2Fimages%2F110111%2F68_102448_4abb2_lit.jpg&refer=http%3A%2F%2Fnews.yzz.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1649250305&t=6a671e69a69338ae3c36edec77b2907d')
                      ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LimitedBox(
                                child: Text('工大软工实训NO.$index组',maxLines: 1,overflow:TextOverflow.ellipsis ,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w900))
                            ),
                            SizedBox(height: 20),
                            LimitedBox(
                                child: Text('[HFUT]第$index条消息，点击查看详情>>>>',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500))
                            ),
                          ],
                        )
                      ]
                  )
                  ),
                  Expanded(
                    flex: 1,
                    child:
                    Column(
                      children: [
                        Text(getTimeStr(),style: TextStyle(fontSize: 8)),
                        SizedBox(height: 50)
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
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text("消息"),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index)=>_singleMessage(index,context))
        ),
    );
  }
  getTimeStr() {
    var now = DateTime.now();
    var format = [yyyy, '-', mm, '-', dd, " ", HH, ":", mm, ":", ss];
    //打印时间 格式
    var time = formatDate(now, format);
    return time;
  }
}