import 'package:flutter/material.dart';
import '../global/state_label_colors.dart';
import '../models/order.dart';


class OrderCard extends StatefulWidget {

  Order order;

  /// 标签颜色
  late Color labelColor;

  final double detailFontSize = 14;

  OrderCard({
    Key? key,
    required this.order
  }) : super(key: key) {
    labelColor = labelColorMap[order.orderState]!;
  }

  Widget createCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 2, bottom: 2),
      child: Card(
        color: Colors.white,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.22,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.orderTitle ?? 'null', style: const TextStyle(fontSize: 18)),
                  RawChip(
                    label: Text(order.orderState),
                    backgroundColor: labelColor,
                    labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.people, color: Colors.grey),
                    ),
                    Text(order.creatorName ?? 'null', style: TextStyle(color: Colors.grey, fontSize: detailFontSize))
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child:  Row(
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(Icons.place, color: Colors.grey)
                    ),
                    Text(
                        order.orderAddress ?? 'null',
                        maxLines: 2,
                        style: const TextStyle (
                            color: Colors.grey,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 12
                        )
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  const Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: Icon(Icons.timer, color: Colors.grey)
                  ),
                  Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text (order.createTime ?? 'null', style: TextStyle (color: Colors.grey, fontSize: detailFontSize))
                  ),
                  Text(order.orderCode ?? 'null', style: TextStyle(color: Colors.grey.shade800, fontSize: detailFontSize))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() => OrderCardState();
}

class OrderCardState extends State<OrderCard> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint(widget.order.orderState);
        Navigator.of(context).pushNamed('/order_detail', arguments: widget.order.id);
      },
      child: widget.createCard(context)
    );
  }
}
