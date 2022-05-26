import 'package:bazaar/Provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/productsProvider.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
  // products == mera productProvider
  // product == mera product
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        )
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            accentColor: Colors.orange,
            fontFamily: 'Lato',
          ),
          home: ProductsOverViewScreen(),
          routes: {
            ProductDetailsScreen.routeName: (ctx) =>
                const ProductDetailsScreen(),
          }),
    );
  }
}
