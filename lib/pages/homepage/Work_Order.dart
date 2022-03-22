import 'dart:async';

import 'package:flutter/material.dart';
import 'package:frontend/global/my_event_bus.dart';
import 'package:frontend/global/theme.dart';
import 'package:frontend/global/user_info.dart';
import 'package:frontend/pages/homepage/Search_Page.dart';
import 'package:frontend/util/net/network_util.dart';
import 'package:provider/provider.dart';

import '../../global/back_end_interface_url.dart';
import '../../widgets/order_with_different_state.dart';

import '../../views/create_work_order.dart';

class WorkOrderPage extends StatefulWidget {
  const WorkOrderPage({Key? key}) : super(key: key);

  @override
  createState() => _WorkOrderPage();
}

class _WorkOrderPage extends State<WorkOrderPage> {

  late TextEditingController _textEditingController;
  late final List<int> _orderCount;
  late StreamSubscription _refreshOrderCount;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.text = "";
    _orderCount = List.filled(_titleState.length, 0);
    _initOrderCount();
    _refreshOrderCount = eventBus.on<RefreshDifferentStateOrderCount>().listen((event) {
      setState(() {
        _initOrderCount();
      });
    });
  }

  void _initOrderCount() {
    for (int i = 0; i < _titleState.length; i++) {
      HttpManager().get(
          findOrderCardDetailCount,
          args: {
            'creatorId': Provider.of<UserInfo>(context, listen: false).accountId,
            'orderState': _titleState[i]
          }
      ).then((value){
        setState(() {
          _orderCount[i] = value;
        });
      });
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  final List<String> _titleItems = [
    '我创建的工单',
    '待分配工单',
    '待抢单工单',
    '待服务工单',
    '服务中工单',
    '待评论工单',
    '已取消工单',
    '异常工单',
  ];

  final List<String> _titleState = [
    '我创建',
    '待分配',
    '待抢单',
    '待服务',
    '服务中',
    '待评论',
    '已取消',
    '异常',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("工单视图"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    showSearch(context: context, delegate: searchBarDelegate());
                  },
                  child: const Icon(Icons.search, color: Colors.white, size: 25),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return CreateOrder();
                    }));
                  },
                  // onTap: (){printWithDebug('add');},
                  child: const Icon(Icons.add, color: Colors.white, size: 25),
                ),
              ],
            ),
          )
        ],
      ),
      body: Scrollbar(
        child: ListView.builder(
              itemCount: _titleItems.length,
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text(_titleItems[index], style: const TextStyle(fontSize: 16)),
                  contentPadding: const EdgeInsets.only(left: 30, right: 10),
                  trailing: Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Row(
                      children: [
                        RawChip(
                          label: Text(_orderCount[index].toString()),
                          padding: const EdgeInsets.all(0),
                          backgroundColor: mainColor,
                          labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded)
                      ],
                    ),
                  ),
                  onTap: (){
                    print(_titleItems[index]);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return DifferentStateOrderList(
                        title: _titleItems[index],
                        state: _titleState[index],
                      );
                    }));
                  },
                );
              },
            )
        ),
    );
  }
}