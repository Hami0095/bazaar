import 'package:bazaar/screens/edit_screen.dart';
import 'package:bazaar/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user-products.dart';
import '../Provider/productsProvider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';

  const UserProductScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditScreen.routeName);
            },
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemBuilder: (_, i) => UserProducts(
              id: productData.items[i].id,
              imgUrl: productData.items[i].imageUrl,
              title: productData.items[i].title,
            ),
            itemCount: productData.items.length,
          ),
          // const Divider(),
        ),
      ),
    );
  }
}
