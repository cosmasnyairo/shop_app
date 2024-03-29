import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import '../models/product.dart';

class Products with ChangeNotifier {
  final String authToken;
  final String userId;

  Products(this.authToken, this._items, this.userId);

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

  Future<void> fetchProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final url =
        'https://shop-app-dc2e5.firebaseio.com/products.json?auth=$authToken&$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final favurl =
          'https://shop-app-dc2e5.firebaseio.com/Favourites/$userId.json?auth=$authToken';
      final favouriteResponse = await http.get(favurl);
      final favouriteData = json.decode(favouriteResponse.body);

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          isFavourite:
              favouriteData == null ? false : favouriteData[prodId] ?? false,
          imageUrl: prodData['imageUrl'],
          price: prodData['price'],
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> addProducts(Product prod) async {
    final url =
        'https://shop-app-dc2e5.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': prod.title,
          'description': prod.description,
          'price': prod.price,
          'imageUrl': prod.imageUrl,
          'creatorId': userId,
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
          'https://shop-app-dc2e5.firebaseio.com/products/$id.json?auth=$authToken';
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
        'https://shop-app-dc2e5.firebaseio.com/products/$id.json?auth=$authToken';
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
