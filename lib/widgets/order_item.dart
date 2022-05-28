import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Provider/orders.dart';

class OrderItem extends StatefulWidget {
  final OrderItems orderItem;

  const OrderItem({
    Key? key,
    required this.orderItem,
  }) : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(children: [
        ListTile(
          title: Text('\$ ${widget.orderItem.amount}'),
          subtitle: Text(
            DateFormat('dd MM yyyy hh:mm').format(widget.orderItem.dateTime),
          ),
          trailing: IconButton(
            icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
            onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            },
          ),
        ),
        if (_expanded)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(widget.orderItem.products.length * 20 + 50, 180),
            // width: MediaQuery.of(context).size.width * 0.75,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Theme.of(context).accentColor),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).primaryColor, spreadRadius: 1),
              ],
            ),
            child: ListView(
                children: widget.orderItem.products
                    .map(
                      (e) => Row(
                        children: [
                          Text(
                            e.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${e.quantity} x    \$ ${e.price}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    .toList()),
          ),
      ]),
    );
  }
}
