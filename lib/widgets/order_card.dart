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
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.31,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            ListTile(
              title: Text(order.orderTitle ?? 'null', style: const TextStyle(fontSize: 18)),
              trailing:  RawChip(
                label: Text(order.orderState),
                backgroundColor: labelColor,
                labelStyle: const TextStyle(color: Colors.white, fontSize: 12),
              )
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.grey),
              title: Text(order.creatorName ?? 'null', style: TextStyle(color: Colors.grey, fontSize: detailFontSize))
            ),
            ListTile(
              leading:  const Icon(Icons.where_to_vote, color: Colors.grey),
              title: Text(
                order.orderAddress ?? 'null',
                maxLines: 2,
                style: const TextStyle (
                  color: Colors.grey,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 12
                )
              )
            ),
            ListTile(
              leading: const Icon(Icons.timer, color: Colors.grey),
              title: Text (order.createTime ?? 'null', style: TextStyle (color: Colors.grey, fontSize: detailFontSize)),
              trailing: Text(order.orderCode ?? 'null', style: TextStyle(color: Colors.grey.shade800, fontSize: detailFontSize)),
            ),
          ],
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
