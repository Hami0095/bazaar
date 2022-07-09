import 'dart:convert';

import 'package:flutter/material.dart';

import './products.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: '29.99',
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: '59.99',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: '19.99',
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: '49.99',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

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
