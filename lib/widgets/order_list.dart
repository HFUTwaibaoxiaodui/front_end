import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/global/back_end_interface_url.dart';
import 'package:frontend/util/net/network_util.dart';
import 'package:frontend/widgets/order_card.dart';
import '../global/future_build.dart';
import '../global/my_event_bus.dart';
import '../models/order.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class OrderListWidget extends StatefulWidget {

  String? withState;
  int? withWorkerId;
  int? withCreatorId;
  String? withOrderName;

  OrderListWidget({Key? key, this.withState, this.withWorkerId, this.withCreatorId, this.withOrderName}) : super(key: key);

  @override
  State<OrderListWidget> createState() => _OrderListWidgetState();
}

class _OrderListWidgetState extends State<OrderListWidget> {

  late Future _orderList;
  late StreamSubscription _initSubscription;
  late StreamSubscription _updateTabViewSubscription;
  List<Order>? _readyToSort;

  @override
  void initState() {
    super.initState();
    _initOrderList();

    _initSubscription = eventBus.on<InitOrderListEvent>().listen((event) {
      _initOrderList();
    });

    _updateTabViewSubscription = eventBus.on<UpdateTabViewEvent>().listen((event) {
      setState(() {
        widget.withState = event.state;
        widget.withWorkerId = event.workerId;
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
    List<Order> _orderList = [];
    List orders;
    if (_isAllNull()) {
      orders = await HttpManager().get(getAllOrders);
    } else {
      orders = await HttpManager().get(
        findOrderCardDetail,
        args: {
          'orderState': widget.withState,
          'workerId': widget.withWorkerId,
          'creatorId': widget.withCreatorId,
          'orderName': widget.withOrderName
        }
      );
    }

    for (var element in orders) {
      setState(() {
        _orderList.add(Order.fromJson(element));
      });
    }

    if (widget.withState == null && widget.withWorkerId == null && widget.withOrderName == null) {
      eventBus.fire(UpdateOrderNumEvent(num: _orderList.length));
    }

    _readyToSort = _orderList;

    return _orderList;
  }

  bool _isAllNull() => widget.withState == null && widget.withWorkerId == null && widget.withCreatorId == null && widget.withOrderName == null;

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
