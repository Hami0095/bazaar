import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/productsProvider.dart';
import '../widgets/products_item.dart';

class ProductGrid extends StatelessWidget {
  bool showFav;
  ProductGrid({
    Key? key,
    required this.showFav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final loadedProducts =
        showFav ? productsData.favouriteItems : productsData.items;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.5,
      ),
      padding: const EdgeInsets.all(10),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: loadedProducts[index],
        child: const ProductItemTile(),
      ),
      itemCount: loadedProducts.length,
    );
  }
}
