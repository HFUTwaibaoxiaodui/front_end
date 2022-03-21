import 'package:flutter/material.dart';
import 'package:frontend/global/theme.dart';
import 'package:frontend/util/debug_print.dart';

import '../../views/create_work_order.dart';

class WorkOrderPage extends StatefulWidget {
  @override
  createState() => _WorkOrderPage();
}

class _WorkOrderPage extends State<WorkOrderPage> {

  bool _showSearchTextField = false;
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _textEditingController.text = "";
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

  Widget _buildSearch() {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: 36,
            maxWidth: MediaQuery.of(context).size.width * 0.6
        ),
        child: TextField(
          controller: _textEditingController,
          onChanged: (input){
            setState(() {
              _textEditingController.text = input;
              _textEditingController.selection = TextSelection.fromPosition(
                  TextPosition(offset: _textEditingController.text.length));
            });
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            hintText: "请输入工单名称",
            contentPadding: const EdgeInsets.all(5),
            border: const OutlineInputBorder()
          )
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: _showSearchTextField ? _buildSearch() : const Text("工单视图"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Row(
              children: [
                GestureDetector(
                  onDoubleTap: (){
                    setState(() {
                      _showSearchTextField = !_showSearchTextField;
                    });
                  },
                  onTap: () {
                    print(_textEditingController.text);
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
                          label: const Text('12'),
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
                  },
                );
              },
            )
        ),
    );
  }
}