import 'package:bazaar/Provider/orders.dart';
import 'package:bazaar/widgets/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/cart.dart';
import '../Provider/themes_provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemesProvider>(context).themeMode == ThemeMode.dark
                ? Colors.black87
                : Colors.white,
        title:
            Text('Your Cart', style: Theme.of(context).textTheme.titleMedium),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              color: Provider.of<ThemesProvider>(context).themeMode ==
                      ThemeMode.dark
                  ? Colors.black87
                  : Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '${cart.totalAmount.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    backgroundColor:
                        Provider.of<ThemesProvider>(context).themeMode ==
                                ThemeMode.dark
                            ? Colors.black87
                            : Colors.white,
                  ),
                  TextButton(
                    child: Text(
                      'Order Now',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) => CartItems(
              id: cart.items.values.toList()[index].id,
              title: cart.items.values.toList()[index].title,
              price: cart.items.values.toList()[index].price,
              quantity: cart.items.values.toList()[index].quantity,
              productId: cart.items.keys.toList()[index],
            ),
            itemCount: cart.items.length,
          ))
        ],
      ),
    );
  }
}
