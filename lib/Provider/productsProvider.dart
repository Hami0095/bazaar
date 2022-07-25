import 'dart:convert';

import 'package:flutter/material.dart';

import './products.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  Product findByID(String id) {
    return items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProduct() async {
    final url = Uri.parse(
      'https://bazaar-8d3e6-default-rtdb.firebaseio.com/products.json',
    );
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach(
        (prodId, prodData) {
          loadedProducts.add(
            Product(
              id: prodId,
              imageUrl: prodData['imageUrl'],
              title: prodData['title'],
              price: prodData['price'],
              description: prodData['description'],
              isFavourite: prodData['isFavorite'] ?? null ? false : false,
            ),
          );
          print('\n loaded data  $loadedProducts ');
        },
      );
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      // ignore: use_rethrow_when_possible
      if (error.runtimeType != Null) {
        print('$error');
      }
      print('$error');
    }
  }

  Future<void> addProduct(Product product) async {
    late final newProduct;
    print('in addProduct()');

    final url = Uri.parse(
      'https://bazaar-8d3e6-default-rtdb.firebaseio.com/products.json',
    );
// https://i.picsum.photos/id/783/200/300.jpg?hmac=dWaIjCNc0MrS2mpEkUX5DxYsTp7vfpipFOlnODFMmfo
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavourite': product.isFavourite
          },
        ),
      );
      newProduct = Product(
        id: json.decode(response.body)['name'],
        imageUrl: product.imageUrl,
        title: product.title,
        price: product.price,
        description: product.description,
      );
      _items.add(newProduct);
      print('Item added');
      notifyListeners();
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  void updateProduct(String id, Product p) {
    // ignore: unused_local_variable
    // const url = Uri.parse(
    //   'https://bazaar-8d3e6-default-rtdb.firebaseio.com/products.json',
    // );
    int prodIndex = _items.indexWhere((element) => element.id == p.id);
    if (prodIndex >= 0) {
      _items[prodIndex] = p;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
