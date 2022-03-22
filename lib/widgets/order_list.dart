import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:frontend/global/back_end_interface_url.dart';
import 'package:frontend/util/debug_print.dart';
import 'package:frontend/util/net/network_util.dart';
import 'package:frontend/widgets/order_card.dart';
import '../global/future_build.dart';
import '../global/my_event_bus.dart';
import '../models/order.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class OrderListWidget extends StatefulWidget {

  String? withStatus;
  int? withWorkerId;
  int? withCreatorId;
  String? orderName;

  OrderListWidget({Key? key, this.withStatus, this.withWorkerId, this.withCreatorId, this.orderName}) : super(key: key);

  @override
  State<OrderListWidget> createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {

  late Future _orderList;
  late StreamSubscription _initSubscription;
  late StreamSubscription _updateTabViewSubscription;

  @override
  void initState() {
    super.initState();
    _initOrderList();
    _initSubscription = eventBus.on<InitOrderListEvent>().listen((event) {
      _initOrderList();
    });

    _updateTabViewSubscription = eventBus.on<UpdateTabViewEvent>().listen((event) {
      setState(() {
        widget.withStatus = event.state;
      });
    });
  }

  @override
  void dispose() {
    _updateTabViewSubscription.cancel();
    _initSubscription.cancel();
    super.dispose();
  }

  void _initOrderList() {
    _orderList = _getOrderList();
  }

  Future _getOrderList() async {
    printWithDebug(getAllOrders);
    List<Order> _orderList = [];
    List orders;
    if (widget.withStatus == null &&
        widget.withWorkerId == null &&
        widget.withCreatorId == null &&
        widget.orderName == null) {
      orders = await HttpManager().get(getAllOrders);
    } else {
      orders = await HttpManager().get(
        findOrderCardDetail,
        args: {
          'orderState': widget.withStatus,
          'workerId': widget.withWorkerId,
          'creatorId': widget.withCreatorId,
          'orderName': widget.orderName
        }
      );
    }

    for (var element in orders) {
      setState(() {
        _orderList.add(Order.fromJson(element));
      });
    }

    if (widget.withStatus == null && widget.withWorkerId == null && widget.withCreatorId == null) {
      eventBus.fire(UpdateOrderNumEvent(num: _orderList.length));
    }

    return _orderList;
  }

  Future<void> _listRefresh() async {
    eventBus.fire(InitOrderListEvent());
  }

  Widget _buildOrderList(List<Order> list) {
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
      body: Container(
        color: Colors.grey.shade200,
        child: Center(
          child: buildFutureBuilder(
              buildWidgetBody: _buildOrderList,
              future: _orderList
          ),
        ),
      ),
    );
  }
}
