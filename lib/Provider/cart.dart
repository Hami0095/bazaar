import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  const CartItem({
    required this.id,
    required this.productId,
    required this.title,
    this.quantity = 1,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  int get itemCount {
    return _items.length == null ? 0 : _items.length;
  }

  void addItem(String productId, String price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          title: existingItem.title,
          price: existingItem.price,
          quantity: existingItem.quantity + 1,
          productId: productId,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: double.parse(price),
          quantity: 1,
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String pid) {
    _items.remove(pid);
    notifyListeners();
  }
}
