import 'package:bazaar/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Provider/cart.dart';
import '../Provider/productsProvider.dart';
import '../Provider/themes_provider.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  // ignore: constant_identifier_names
  Favourites,
  // ignore: constant_identifier_names
  All,
}

class ProductsOverViewScreen extends StatefulWidget {
  const ProductsOverViewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverViewScreen> createState() => _ProductsOverViewScreenState();
}

class _ProductsOverViewScreenState extends State<ProductsOverViewScreen> {
  final loadedProducts = [];
  var showOnlyFav = false;
  bool _isInit = true;
  bool _isLoading = false;
  @override
  void initState() {
    // Future.delayed(Duration.zero).then(
    //   (_) => Provider.of<ProductsProvider>(context).fetchAndSetProduct(),
    // );
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchAndSetProduct().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final productsContainer =
        Provider.of<ProductsProvider>(context, listen: false);
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        backgroundColor:
            Provider.of<ThemesProvider>(context).themeMode == ThemeMode.dark
                ? Colors.black87
                : Colors.white,
        actions: [
          PopupMenuButton(
            itemBuilder: ((context) => [
                  PopupMenuItem(
                    child: Text(
                      'My Favourites',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    value: FilterOptions.Favourites,
                  ),
                  PopupMenuItem(
                    child: Text(
                      'Show All',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    value: FilterOptions.All,
                  ),
                ]),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).iconTheme.color,
            ),
            onSelected: (FilterOptions selectedIndex) {
              setState(
                () {
                  if (selectedIndex == FilterOptions.Favourites) {
                    showOnlyFav = true;
                  } else {
                    showOnlyFav = false;
                  }
                },
              );
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
              color: Colors.white,
            ),
            child: IconButton(
                color: Theme.of(context).iconTheme.color,
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).iconTheme.color,
                )),
          ),
        ],
        title: Text(
          'Bazaar',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: _isLoading
          ? const SplashScreen(
              route: ProductsOverViewScreen(),
            )
          : ProductGrid(
              showFav: showOnlyFav,
            ),
    );
  }
}
