import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './Provider/orders.dart';
import './Provider/themes_provider.dart';
import './Provider/productsProvider.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './Provider/cart.dart';
import './screens/cart_screen.dart';
import './screens/order_screen.dart';
import './screens/edit_screen.dart';
import './screens/splash_screen.dart';
import './screens/user_product_screen.dart';
import './Themes/mythemes.dart';

void main() {
  runApp(const MyApp());
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
          create: (ctx) => ThemesProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      builder: (context, _) {
        final _themeProvider = Provider.of<ThemesProvider>(context);
        return MaterialApp(
          title: 'Bazaar',
          themeMode: _themeProvider.themeMode,
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          home: const SplashScreen(route: ProductsOverViewScreen()),
          routes: {
            ProductDetailsScreen.routeName: (ctx) =>
                const ProductDetailsScreen(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            OrderScreen.routeName: (ctx) => const OrderScreen(),
            UserProductScreen.routeName: (ctx) => const UserProductScreen(),
            EditScreen.routeName: ((ctx) => const EditScreen()),
          },
        );
      },
      // child: MaterialApp(
      //   title: 'Flutter Demo',
      //   theme: ThemeData(
      //     primarySwatch: Colors.deepOrange,
      //     accentColor: Colors.orange,
      //     fontFamily: 'Lato',
      //   ),
      //   home: const SplashScreen(route: ProductsOverViewScreen()),
      //   routes: {
      //     ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen(),
      //     CartScreen.routeName: (ctx) => const CartScreen(),
      //     OrderScreen.routeName: (ctx) => const OrderScreen(),
      //     UserProductScreen.routeName: (ctx) => const UserProductScreen(),
      //     EditScreen.routeName: ((ctx) => const EditScreen()),
      //   },
      // ),
    );
  }
}
