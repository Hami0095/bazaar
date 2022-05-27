import 'package:clay_containers/clay_containers.dart';
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
        leading: ClayContainer(
          color: Theme.of(context).primaryColorDark,
          height: 90,
          width: 90,
          customBorderRadius: const BorderRadius.only(
              topRight: Radius.elliptical(150, 150),
              bottomLeft: Radius.circular(50)),
        ),
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
