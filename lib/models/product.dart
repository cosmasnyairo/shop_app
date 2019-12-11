import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  void _setFavourite(bool v) {
    isFavourite = v;
    notifyListeners();
  }

  void toggleFavourite(String authToken, String userId) async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = 'https://shop-app-dc2e5.firebaseio.com/Favourites/$userId/$id.json?auth=$authToken';
    try {
      final response = await http.patch(
        url,
        body: json.encode({   
          'isFavourite': isFavourite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFavourite(oldStatus);
      }
    } catch (e) {
      _setFavourite(oldStatus);
    }
  }
}
