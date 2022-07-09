import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/cart.dart';
import '../Provider/themes_provider.dart';

class CartItems extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String productId;
  const CartItems({
    Key? key,
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(productId),
      background: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        color: Theme.of(context).errorColor,
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
        alignment: Alignment.centerRight,
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Text(
                '\$ $price',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            backgroundColor:
                Provider.of<ThemesProvider>(context).themeMode == ThemeMode.dark
                    ? Colors.black87
                    : Colors.white,
            radius: 25,
          ),
          title: Text(title),
          subtitle: Text('\$ ${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text(
              'Are You Sure?',
            ),
            content: const Text(
              'Do you want to remove the item from the cart permanently?',
            ),
            actions: [
              TextButton(
                child: Text(
                  'No',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
              ),
              TextButton(
                child: Text(
                  'YES',
                  style: TextStyle(
                    color: Theme.of(context).errorColor,
                  ),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
