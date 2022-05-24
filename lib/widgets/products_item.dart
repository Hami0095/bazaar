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
    return GridTile(
      child: Image.network(
        imgUrl,
        fit: BoxFit.cover,
      ),
      footer: GridTileBar(
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
