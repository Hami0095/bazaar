import 'package:bazaar/Provider/productsProvider.dart';
import 'package:bazaar/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/products.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverViewScreen extends StatefulWidget {
  const ProductsOverViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  final loadedProducts = [];

  @override
  Widget build(BuildContext context) {
    var showOnlyFav = false;
    final productsContainer =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            itemBuilder: ((context) => [
                  const PopupMenuItem(
                    child: Text('My Favourites'),
                    value: FilterOptions.Favourites,
                  ),
                  const PopupMenuItem(
                    child: Text('Show All'),
                    value: FilterOptions.All,
                  ),
                ]),
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedIndex) {
              setState(() {
                if (selectedIndex == FilterOptions.Favourites) {
                  showOnlyFav = true;
                } else {
                  showOnlyFav = false;
                }
              });
            },
          ),
        ],
        title: const Text('Bazaar'),
      ),
      body: ProductGrid(showFav: showOnlyFav),
    );
  }
}
