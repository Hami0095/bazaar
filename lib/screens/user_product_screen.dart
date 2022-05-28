import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user-products.dart';
import '../Provider/productsProvider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-product-screen';

  const UserProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Product Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            ListView.builder(
              itemBuilder: (_, i) => UserProducts(
                imgUrl: productData.items[i].imageUrl,
                title: productData.items[i].title,
              ),
              itemCount: productData.items.length,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
