import 'package:flutter/material.dart';
import 'package:frontend/global/theme.dart';
import 'package:frontend/widgets/order_list.dart';
import 'package:provider/provider.dart';

import '../global/user_info.dart';

class DifferentStateOrderList extends StatefulWidget {
  final String? title;
  final String? state;

  const DifferentStateOrderList({Key? key, this.title, this.state}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DifferentStateOrderListState();

}

class _DifferentStateOrderListState extends State <DifferentStateOrderList> {
  @override

  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         leading: _buildLeading(context),
         backgroundColor: mainColor,
         elevation: 0.5,
         centerTitle: true,
         title: Text(widget.title!, style: const TextStyle(color: Colors.white))
       ),
       endDrawer: SafeArea(
         child: Drawer(
           child: Container(
             color: Colors.red,
             height: MediaQuery.of(context).size.height,
             padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
             child: Column(
               children: [
                 Container(color: Colors.green, child: Text('123123')),
                 Divider(thickness: 0.5, color: Colors.grey.shade200),
                 Container(color: Colors.green, child: Text('123123'))
               ],
             ),
           ),
         ),
       ),
       body: OrderListWidget(
         withState: widget.state,
         withCreatorId: Provider.of<UserInfo>(context, listen: false).accountId,
       )
     );
  }

  Widget _buildLeading(BuildContext context) {
    return GestureDetector(
         onTap: (){
           Navigator.of(context).pop();
         },
         child: const Icon(Icons.arrow_back),
       );
  }
}