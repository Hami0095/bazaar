import 'package:bazaar/Provider/productsProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = 'product-detail';

  const ProductDetailsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments;
    final productItem = Provider.of<ProductsProvider>(
      context,
      listen: false,
    ).findByID(productId.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(productItem.title),
      ),
    );
  }
}
