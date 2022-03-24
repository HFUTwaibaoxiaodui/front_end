import 'package:flutter/material.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:flutter_pickers/style/picker_style.dart';

class AddressPickerPage extends StatefulWidget {
  @override
  _AddressPickerPageState createState() => _AddressPickerPageState();
}

class _AddressPickerPageState extends State<AddressPickerPage> {

  List locations2 = ['四川省', '成都市', '双流区'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('更多参数说明'),
            SizedBox(height: 6),
            _checkLocation(),
          ],
        ),
      ),
    );
  }
  Widget _checkLocation() {
    double menuHeight = 36.0;
    Widget _headMenuView = Container(
        color: Colors.grey[700],
        height: menuHeight,
        child: Row(children: [
          Expanded(child: Center(child: Text('省', style: TextStyle(color: Colors.white),))),
          Expanded(child: Center(child: Text('市', style: TextStyle(color: Colors.white),))),
          Expanded(child: Center(child: Text('区', style: TextStyle(color: Colors.white),))),
        ]));

    Widget _cancelButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(left: 22),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(4)),
      child: Text('取消', style: TextStyle(color: Colors.white,fontSize: 14),),
    );

    Widget _commitButton = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(right: 22),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4)),
      child: Text('确认', style: TextStyle(color: Colors.white,fontSize: 14),),
    );

    // 头部样式
    Decoration headDecoration = BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)));

    Widget title =
    Center(child: Text('请选择地址', style: TextStyle(color: Colors.white,fontSize: 14),),);

    /// item 覆盖样式
    Widget itemOverlay = Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
            horizontal: BorderSide(color: Colors.grey, width: 0.7)),
      ),
    );

    var pickerStyle = PickerStyle(
      menu: _headMenuView,
      menuHeight: menuHeight,
      cancelButton: _cancelButton,
      commitButton: _commitButton,
      headDecoration: headDecoration,
      title: title,
      textColor: Colors.white,
      backgroundColor: Colors.grey[800],
      itemOverlay: itemOverlay,
    );

    return InkWell(
      onTap: () {
        Pickers.showAddressPicker(
          context,
          initProvince: locations2[0],
          initCity: locations2[1],
          initTown: locations2[2],
          pickerStyle: pickerStyle,
          addAllItem: false,
          onConfirm: (p, c, t) {
            setState(() {
              locations2[0] = p;
              locations2[1] = c;
              locations2[2] = t;
            });
          },
        );
      },
      child: Text(
          spliceCityName(
              pname: locations2[0], cname: locations2[1], tname: locations2[2]),
          style: TextStyle(fontSize: 16)),

    );

  }

  // 拼接城市
  String spliceCityName({String? pname, String? cname, String? tname}) {
    if (strEmpty(pname)) return '不限';
    StringBuffer sb = StringBuffer();
    sb.write(pname);
    if (strEmpty(cname)) return sb.toString();
    sb.write(' - ');
    sb.write(cname);
    if (strEmpty(tname)) return sb.toString();
    sb.write(' - ');
    sb.write(tname);
    return sb.toString();
  }

  /// 字符串为空
  bool strEmpty(String? value) {
    if (value == null) return true;

    return value.trim().isEmpty;
  }
}
