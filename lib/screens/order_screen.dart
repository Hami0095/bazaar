import 'package:bazaar/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/orders.dart';
import '../Provider/themes_provider.dart';
import '../widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  const OrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Orders',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor:
            Provider.of<ThemesProvider>(context).themeMode == ThemeMode.dark
                ? Colors.black87
                : Colors.white,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemBuilder: (ctx, i) => OrderItem(orderItem: orderData.orders[i]),
        itemCount: orderData.orders.length,
      ),
    );
  }
}
