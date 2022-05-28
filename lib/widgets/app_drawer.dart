import 'package:bazaar/screens/order_screen.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Hello Friend!'),
            ),
            ListTile(
              leading: const Icon(Icons.shop),
              title: const Text('Shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.payment),
              title: const Text('Orders Screen'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrderScreen.routeName);
              },
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
