import 'package:bazaar/widgets/products_grid.dart';
import 'package:bazaar/widgets/products_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../Provider/products.dart';

class ProductsOverViewScreen extends StatelessWidget {
  ProductsOverViewScreen({Key? key}) : super(key: key);

  final loadedProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bazaar'),
      ),
      body: const ProductGrid(),
    );
  }
}
