import 'package:provider/provider.dart';

import 'package:bazaar/Provider/themes_provider.dart';
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
              title: Text(
                'Hello Friend!',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            ListTile(
              leading:
                  Icon(Icons.shop, color: Theme.of(context).iconTheme.color),
              title: Text('Shop', style: Theme.of(context).textTheme.bodyLarge),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
            Divider(color: Theme.of(context).dividerColor),
            ListTile(
              leading:
                  Icon(Icons.payment, color: Theme.of(context).iconTheme.color),
              title: Text(
                'Orders Screen',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrderScreen.routeName);
              },
            ),
            Divider(
              color: Theme.of(context).dividerColor,
            ),
            //TO-DO update the lower box with the user product screen.
            ListTile(
              leading:
                  Icon(Icons.edit, color: Theme.of(context).iconTheme.color),
              title: Text(
                'Manage products',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductScreen.routeName);
              },
            ),
            Divider(
              color: Theme.of(context).dividerColor,
            ),
            Card(
              color: Theme.of(context).drawerTheme.backgroundColor,
              elevation: 0.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.color_lens),
                    Text('Themes'),
                    ChangeThemeButton(),
                  ],
                ),
              ),
            ),
            Divider(color: Theme.of(context).dividerColor, thickness: 2.0),
          ],
        ),
      ),
    );
  }
}
