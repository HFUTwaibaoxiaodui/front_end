import 'package:flutter/material.dart';
import '../../global/theme.dart';
import '../order_detail.dart';
import 'package:frontend/pages/homepage/Check_Person_Manage.dart';

class PersonManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PersonManagePage();
}

class _PersonManagePage extends State<PersonManagePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _listBuild();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.5,
        centerTitle: true,
        title: Text("人员管理"),
      ),
      // resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      body:Container(
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.06,
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.only(left: 10,right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Row(
                children: [
                  Expanded(child: TextField(
                    decoration: InputDecoration(
                        hintText: '请输入搜索内容',
                        border: InputBorder.none
                    ),
                  )),
                  Icon(Icons.search)
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child:ListView(
                children: list_use,
              ) ,
            ),
          ],
        ),
      ),
    );
  }

  List<String> person_list = [
    '姓名：','电话：','所属机构：','巡检类型：','角色：',
  ];
  List<String> person_detail_list = [
    '张0','15905695658','巡检端','打扫卫生','巡检员',
    '张1','15905695658','巡检端','打扫卫生','巡检员',
    '张2','15905695658','巡检端','打扫卫生','巡检员',
    '张3','15905695658','巡检端','打扫卫生','巡检员',
    '张0','15905695658','巡检端','打扫卫生','巡检员',
    '张1','15905695658','巡检端','打扫卫生','巡检员',
    '张2','15905695658','巡检端','打扫卫生','巡检员',
    '张3','15905695658','巡检端','打扫卫生','巡检员',
  ];
  List<Widget> list_use = [];

  void _listBuild(){

    for(int i = 0; i <(person_detail_list.length)/5; i++){
      list_use.add(Container(
        margin: EdgeInsets.only(right: 20,left: 20),
        child: InkWell(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return PersonDetailPage();
            }));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(person_list[0]+person_detail_list[i*5+0],),
              Text(person_list[1]+person_detail_list[i*5+1],),
              Text(person_list[2]+person_detail_list[i*5+2],),
              Text(person_list[3]+person_detail_list[i*5+3],),
              Text(person_list[4]+person_detail_list[i*5+4],),
              Divider(),
            ],
          ),

        ),
      ));
    }
    print('========='+list_use.length.toString()+'=========');

  }
}
