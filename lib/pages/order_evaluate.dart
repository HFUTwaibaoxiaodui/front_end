import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../global/back_end_interface_url.dart';
import '../global/my_event_bus.dart';
import '../util/net/network_util.dart';

class OrderEvaluate extends StatefulWidget {

  int id;
  String name;

  OrderEvaluate({Key? key, required this.id, required this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OrderEvaluateState();
}

class OrderEvaluateState extends State<OrderEvaluate> {
  late TextEditingController _handleResult;
  late TextEditingController _handleSuggest;
  late FocusNode _focusNode;
  late int _score;
  final Map<int, String> _scoreMap = {
    2 : '非常不满',
    4 : '不满',
    6 : '一般',
    8 : '满意',
    10 : '非常满意'
  };


  @override
  void initState() {
    super.initState();

    _handleResult = TextEditingController();
    _handleSuggest = TextEditingController();
    _focusNode = FocusNode();
    _handleResult.text = "已解决";
    _handleSuggest.text = "";
    _score = 2;

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
      } else {
        print('失去焦点');
      }
    });
  }

  @override
  void dispose() {
    _handleResult.dispose();
    _handleSuggest.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('工单评价',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.cyanAccent.shade700,
        // 底部阴影
        elevation: 0.5,
      ),
      body: Builder(
        builder: (context) {
          return Container(
            color: Colors.grey.shade300,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Expanded(child: ListTile(title: Text('问题解决情况', style: TextStyle(fontSize: 16))), flex: 4),
                          Expanded(
                            child: RadioListTile<String>(
                              contentPadding: const EdgeInsets.all(0),
                              value: "已解决",
                              title: const Text("已解决", style: TextStyle(fontSize: 14)),
                              groupValue: _handleResult.text,
                              onChanged: (value) {
                                setState(() {
                                  _handleResult.text = value!;
                                });
                              }),
                            flex: 3,
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              contentPadding: const EdgeInsets.all(0),
                              value: "未解决",
                              title: const Text("未解决", style: TextStyle(fontSize: 14)),
                              groupValue: _handleResult.text,
                              onChanged: (value) {
                                setState(() {
                                  _handleResult.text = value!;
                                });
                              }),
                            flex: 3
                          ),
                        ],
                      ),
                      _handleResult.text == "已解决" ?
                          Container() :
                          Column(
                            children: [
                              Divider(thickness: 0.5, color: Colors.grey.shade400),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Expanded(
                                      child: ListTile(title: Text('问题描述')), flex: 2),
                                  Expanded(
                                      child: ListTile(
                                        contentPadding: const EdgeInsets.only(top: 14),
                                        title: TextField(
                                          focusNode: _focusNode,
                                          controller: _handleSuggest,
                                          decoration: const InputDecoration.collapsed(
                                            hintStyle: TextStyle(
                                                color: CupertinoColors.inactiveGray),
                                            hintText: "问题描述",
                                            border: InputBorder.none,
                                          ),
                                          maxLines: 5,
                                          maxLength: 300,
                                        ),
                                      ),
                                      flex: 3),
                                  Expanded(child: Container(), flex: 1),
                                ],
                              ),
                            ],
                          ),
                      Divider(thickness: 0.5, color: Colors.grey.shade400),
                      Row(
                        children: [
                          const Expanded(flex: 2,
                            child: ListTile(title: Text('评分', style: TextStyle(fontSize: 16))),
                          ),
                          Expanded(flex: 6,
                            child: RatingBar.builder(
                              initialRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              minRating: 1,
                              itemCount: 5,
                              itemSize: 25.0,
                              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  _score = (rating * 2).toInt();
                                });
                              },
                            )
                          ),
                          Expanded(flex: 3, child: ListTile(title: Text(_scoreMap[_score]!, style: const TextStyle(fontSize: 14))))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  padding: const EdgeInsets.all(15),
                  child: Center(
                    child: GestureDetector(
                        onTap: () {
                          SnackBar snackBar;
                          if (_handleSuggest.text == '为解决' && _handleSuggest.text == "") {
                            snackBar = const SnackBar(
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.red,
                              content: Text('请填写处理意见!'),
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                          } else {

                            HttpManager().put(updateOrderState, args: {'orderId': widget.id, 'orderState': '已完成'});

                            HttpManager().post(
                              addOrderEvaluate,
                              args: {
                                'orderId': widget.id,
                                'situation': _handleResult.text,
                                'description' : _handleSuggest.text,
                                'score': _score
                              }
                            );

                            String formattedDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd, ' ', hh, ':', nn, ':', ss]);
                            HttpManager().post(
                                addOperationLog,
                                args: {
                                  'orderId': widget.id,
                                  'operationTime': formattedDate,
                                  'operationName': '服务评价',
                                  'description': '【' + widget.name + '】已经对本次巡检任务进行评价'
                                }
                            ).then((value){
                              /// 提示用户抢单成功
                              // Fluttertoast.showToast(
                              //     msg: "抢单成功",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     backgroundColor: Colors.green,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0
                              // );
                              eventBus.fire(RefreshOrderDetailEvent());
                              eventBus.fire(InitOrderListEvent());
                              /// 返回上一个界面
                              Navigator.of(context).pop();
                            });
                          }
                        },
                        child: Container(
                          color: Colors.cyanAccent.shade700,
                          child: const Center(
                            child: Text('提交',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18)),
                          ),
                        )),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
