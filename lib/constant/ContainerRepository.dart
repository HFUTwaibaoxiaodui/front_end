import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerRepository extends Container{
  final Widget child;
  final double width;
  final Decoration decoration;
  final Function onTap;  // 添加点击事件

  ContainerRepository({
    Key key,
    this.child,
    this.width,
    this.decoration,
    this.onTap, EdgeInsets padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w = Container(
      decoration: decoration,
      width: width,
      child: InkWell(               // 添加点击事件
        child: child,
        onTap: onTap,
      ),
    );

    return w;
  }
}
