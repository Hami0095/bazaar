import 'package:bazaar/Provider/orders.dart';
import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  final OrderItems orderItem;

  const OrderItem({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$ ${orderItem.amount}'),
          subtitle: Text(''),
        ),
      ]),
    );
  }
}
