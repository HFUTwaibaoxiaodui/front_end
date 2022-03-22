import 'package:flutter/material.dart';
import '../../global/theme.dart';
import '../order_detail.dart';

class PersonDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        // leading: GestureDetector(child: Icon(Icons.swap_horiz),onTap: (){
        //   Navigator.push(context, MaterialPageRoute(builder: (_) {
        //     return DetailPage();
        //   }));
        // },),
        backgroundColor: mainColor,
        elevation: 0.5,
        centerTitle: true,
        title: Text("查看服务人员"),
      ),
      body:Container(
        height: MediaQuery.of(context).size.height * 0.753,
        color: Colors.white,
          child:ListView.builder(
            itemCount: list_person.length,
            itemBuilder: (BuildContext context, int index){
              return Container(
                child: ListTile(
                  title: Text(list_person[index], style: const TextStyle(fontSize: 16)),
                  contentPadding: const EdgeInsets.only(left: 30, right: 10),
                  // onTap: (){
                  //   print(_titleItems[index]);
                  // },
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey.shade400))
                ),
              );
            },


          )


      ),
    );
  }

  List<String> list_person = [
    '姓名','性别','手机','邮箱','所属机构','角色','证书编号','从业年限','职称','级别',
  ];
  List<String> list_detail_person = [];

}
