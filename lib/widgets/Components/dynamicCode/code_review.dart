import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'tools/dzy_theme.dart';
import 'code_paint.dart';
import 'package:random_string/random_string.dart';

// 当前存在的问题是，必须在外部调用的时候给一个初始值
class CodeReview extends StatefulWidget {
  CodeReview({Key? key, required this.text, this.onTap}) : super(key: key);
  final String text;
  final onTap;
  _CodeReviewState createState() => _CodeReviewState();
}

class _CodeReviewState extends State<CodeReview> {
  String? _ranStr;
  int? _textLength;
  double? _width;
  double? _height;
  List<Offset> _lineOffsets = <Offset>[];
  Color _ranColor = DzyTheme.randomColor();

  void _randLines() {
    _lineOffsets.clear();
    for (var i = 0; i < _textLength!; i++) {
      double fromX = randomBetween(10, 20).toDouble();
      double fromY = randomBetween(3, 33).toDouble();
      Offset from = Offset(fromX, fromY);
      _lineOffsets.add(from);

      double endX = randomBetween(60, _width!.toInt() - 10).toDouble();
      double endY = randomBetween(3, 33).toDouble();
      Offset end = Offset(endX, endY);
      _lineOffsets.add(end);
    }
    _ranColor = DzyTheme.randomColor();
  }

  @override
  void initState() {
    super.initState();
    _textLength = widget.text.length;
    _width = _textLength!.toDouble() * 22;
    _height = 36;
    _ranStr = widget.text;
    _randLines();

    // initState 中设置回调后不可以调用 setState 方法否则报错，否则运行出错
    // widget.onTap(_ranDtr);
    // _changeCode();
  }

  void _changeCode() {
    _ranStr = randomAlphaNumeric(_textLength);
    widget.onTap(_ranStr);
    setState(() {
      _randLines();
    });
  }

  Container _subString(index) {
    // 首次返回对应字母
    // widget.currentStr(_ranDtr);
    return Container(
      padding: EdgeInsets.only(
          left: 2, right: 2, top: randomBetween(0, 14).toDouble()),
      child: Transform.rotate(
        angle: pi / randomBetween(3, 30) * randomBetween(-1, 1),
        child: Text(_ranStr![index],
            style: TextStyle(
                fontSize: randomBetween(16, 18).toDouble(),
                color: DzyTheme.randomColor())),
      ),
    );
  }

  Container _backLines() {
    // 父类模块和子类模块最少有一个设置大小

    return Container(
      width: _width,
      height: _height,
      child: CustomPaint(
        // size: Size(_width, _height),
        painter: CodePaint(_lineOffsets, _ranColor),
        foregroundPainter: CodePaint(_lineOffsets, _ranColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _width,
      height: _height,
      color: Colors.grey[200],
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _backLines(),
          _backLines(),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _changeCode,
            child: Container(
              width: _width,
              height: _height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_textLength!, (int index) {
                  return _subString(index);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
