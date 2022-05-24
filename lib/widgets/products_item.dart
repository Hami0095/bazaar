import 'package:bazaar/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';

class ProductItemTile extends StatelessWidget {
  const ProductItemTile({
    Key? key,
    required this.id,
    required this.imgUrl,
    required this.title,
  }) : super(key: key);
  final String id;
  final String imgUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailsScreen.routeName, arguments: id);
          },
          child: Image.network(
            imgUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: const Icon(
              Icons.favorite,
            ),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
