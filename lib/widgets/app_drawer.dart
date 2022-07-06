import 'package:bazaar/screens/order_screen.dart';
import 'package:bazaar/screens/user_product_screen.dart';
import 'package:bazaar/widgets/theme_change_btn.dart';
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
            //TO-DO update the lower box with the user product screen.
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Manage products'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductScreen.routeName);
              },
            ),
            const Divider(),
            Card(
              elevation: 2.0,
              child: Row(
                children: [
                  const Text('Themes'),
                  Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                  ),
                  const ChangeThemeButton(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
