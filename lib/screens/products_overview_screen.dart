import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductsOverViewScreen extends StatelessWidget {
  const ProductsOverViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bazaar'),
      ),
      body: MasonryGridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 9,
        mainAxisSpacing: 10,
        itemBuilder: (ctx, index) {
          return Container(
            height: index % 2 == 0 ? 120 : 300,
            color: index % 2 == 0 ? Colors.black : Colors.deepOrange,
            child: Text(index.toString()),
          );
        },
        itemCount: 50,
      ),
    );
  }
}
