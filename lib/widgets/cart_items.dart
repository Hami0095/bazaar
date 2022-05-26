import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  const CartItems({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 15,
      ),
      child: ListTile(
        // leading: CircleAvatar(
        //   child: Text('\$ $price'),
        //   radius: 50,
        // ),
        title: Text(title),
        subtitle: Text('\$ ${price * quantity}'),
        trailing: Text('$quantity x'),
      ),
    );
  }
}
