import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import '../models/product.dart';

const url = 'https://shop-app-dc2e5.firebaseio.com/products.json';

class Products with ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favourites {
    return _items.where((test) => test.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          imageUrl: prodData['imageUrl'],
          price: prodData['price'],
          isFavourite: prodData['isFavourite'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProducts(Product prod) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': prod.title,
          'description': prod.description,
          'price': prod.price,
          'imageUrl': prod.imageUrl,
          'isFavourite': prod.isFavourite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: prod.title,
        description: prod.description,
        price: prod.price,
        imageUrl: prod.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProducts(String id, Product prod) async {
    final prodIndex = _items.indexWhere((test) => test.id == id);
    if (prodIndex >= 0) {
      final producturl =
          'https://shop-app-dc2e5.firebaseio.com/products/$id.json';
      await http.patch(producturl,
          body: json.encode({
            'title': prod.title,
            'description': prod.description,
            'price': prod.price,
            'imageUrl': prod.imageUrl,
          }));
      _items[prodIndex] = prod;
      notifyListeners();
    } else {}
  }

  Future<void> deleteProduct(String id) async {
    final producturl =
        'https://shop-app-dc2e5.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((test) => test.id == id);
    var existingProduct = _items[existingProductIndex];
    //store copy of product temporarily
    _items.removeAt(existingProductIndex);
    // remove original product from memory
    notifyListeners();
    final response = await http.delete(producturl);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      //return product to list if error is met 
      notifyListeners();
      throw HttpException('Unable to delete Product');
    }
    existingProduct = null;

    //optimistic delete and rollback
  }
}
