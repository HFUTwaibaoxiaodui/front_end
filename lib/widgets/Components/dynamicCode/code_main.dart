import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'code_review.dart';


class MyCode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyCodeState();
  }
}
class _MyCodeState extends State<MyCode> {
  int _codeLength = 4;
  String _codeStr = randomAlphaNumeric(4);

  TextEditingController _controller = TextEditingController();
  FocusNode _node = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _node.addListener(() {
      if(!_node.hasFocus){
        var text = _controller.text.trim()..toLowerCase();
        if (text != _codeStr.toLowerCase()) {
          Fluttertoast.showToast(
              msg: "图片验证码错误",
          );
          debugPrint('Wrong code!-------------------------');
        }else{
          Fluttertoast.showToast(
            msg: "图片验证码正确",
          );
          debugPrint('Right code!-------------------------');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(widget.title),
    //   ),
    //   body: Center(
      return Center(
        child: Row(
          children: <Widget>[
            Expanded(child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(_codeLength),
                  // WhitelistingTextInputFormatter(RegExp("[0-9a-zA-Z]"))
                ],
                controller: _controller,
                focusNode: _node,
                onChanged: (text) {
                  debugPrint(text.trim() + _codeStr);
                },

                decoration: InputDecoration(hintText: 'enter code'),
              ),
            )),
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CodeReview(
                text: _codeStr,
                onTap: (text) {
                  setState(() {
                    _codeStr = text;
                  });
                },
              ),
            ),
          ],
        ),
      );
    // );
  }
}
