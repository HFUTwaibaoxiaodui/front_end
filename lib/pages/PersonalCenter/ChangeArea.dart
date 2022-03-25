import 'package:flutter/material.dart';
import 'package:city_pickers/city_pickers.dart';

class ChineseCityPickerPage extends StatefulWidget {
  @override
  ChineseCityPickerPageState createState() => new ChineseCityPickerPageState();
}

class ChineseCityPickerPageState extends State<ChineseCityPickerPage> {

  String area='';
  String area1='';
  String area2='';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('城市三级联动选择器'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Container(
              child: InkWell(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.add_location),
                    this.area.length>0?Text("$area",style: const TextStyle(fontSize: 13,
                        color: Colors.black54
                    ),):Text("省/市/区",style: TextStyle(fontSize: 13,
                        color: Colors.black54))
                  ],
                ),
                onTap: () async{
                  Result? result = await CityPickers.showCityPicker(
                      context: context,
                      cancelWidget: Text("取消",style: TextStyle(color: Colors.black),),
                      confirmWidget: Text("确定",style: TextStyle(color: Colors.black),)
                  );
                  print(result);
                  setState(() {
                    this.area="${result?.provinceName}/${result?.cityName}/${result?.areaName}";

                  });
                },
              ),

            ),
            SizedBox(height: 40,),

          ],
        ),
      ),
    );
  }
}
