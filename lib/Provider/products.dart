import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  late final String id;
  late final String imageUrl;
  late final String title;
  late final String price;
  late final String description;
  bool isFavourite;
  Product({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    this.isFavourite = false,
  });

  void toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
