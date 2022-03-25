import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/global/back_end_interface_url.dart';
import 'package:frontend/global/theme.dart';
import 'package:frontend/util/net/network_util.dart';
import 'package:frontend/widgets/order_card.dart';

import '../../global/future_build.dart';
import '../../global/my_event_bus.dart';
import '../../models/order.dart';
import '../../util/android_activity_visitor.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class SortPageWidget extends StatefulWidget {

  String? withState;
  int? withWorkerId;
  int? withCreatorId;
  String? withOrderName;

  SortPageWidget({Key? key, this.withState, this.withWorkerId, this.withCreatorId, this.withOrderName}) : super(key: key);

  @override
  State<SortPageWidget> createState() => _SortPageWidgetState();
}

class _SortPageWidgetState extends State<SortPageWidget> {

  late Future _SortPage;
  late StreamSubscription _initSubscription;
  late StreamSubscription _updateTabViewSubscription;
  List<Order>? _readyToSort;

  @override
  void initState() {
    super.initState();
    _initSortPage();
  }

  @override
  void dispose() {
    _updateTabViewSubscription.cancel();
    _initSubscription.cancel();
    super.dispose();
  }

  void _initSortPage() {
    _SortPage = _getSortPage();
    print("INIT____________________");
  }

  Future _getSortPage() async {
    List<Order> _SortPage = [];
    List orders;
    double d1=0;
    double d2=0;

      AndroidActivityVisitor.getDistance().then((value){
        setState(() {
          d1=value['latitude'];
          d2=value['longitude'];
        });
      });
      orders = await HttpManager().get(
          sortOrder,
          args: {
            'currentLatitude': d1,
            'currentLongitude': d2,
          }
      );

    for (var element in orders) {
      print(orders);
      setState(() {
        _SortPage.add(Order.fromJson(element));
      });
    }

    if (widget.withState == null && widget.withWorkerId == null && widget.withOrderName == null) {
      eventBus.fire(UpdateOrderNumEvent(num: _SortPage.length));
    }

    _readyToSort = _SortPage;

    return _SortPage;
  }

  bool _isAllNull() => widget.withState == null && widget.withWorkerId == null && widget.withCreatorId == null && widget.withOrderName == null;

  Future<void> _listRefresh() async {
    eventBus.fire(InitOrderListEvent());
  }

  Widget _buildSortPage(List<Order> list) {
    return RefreshIndicator(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return OrderCard(order: list[index]);
          },
        ),
        onRefresh: () {
          return _listRefresh();
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: RichText(
          text: const TextSpan(
            text: "快捷寻单",
            style: TextStyle(fontSize: 18),
            children: [
              TextSpan(
                  text: "—按据当前距离由近到远",
                  style: TextStyle(fontSize: 12)
              ),
            ]
          ),
        ),
        backgroundColor: mainColor,
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Center(
          child: buildFutureBuilder(
              buildWidgetBody: _buildSortPage,
              future: _SortPage
          ),
        ),
      ),
    );
  }
}
