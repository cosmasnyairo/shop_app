import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../models/order.dart';

class Orders with ChangeNotifier {
  final String authToken;
  final String userId;
  Orders(
    this.authToken,
    this._orders,
    this.userId,
  );
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchOrder() async {
    final url =
        'https://shop-app-dc2e5.firebaseio.com/orders/$userId.json?auth=$authToken';
    final response = await http.get(url);
    final List<Order> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        Order(
          id: orderId,
          amount: orderData['amount'],
          time: DateTime.parse(orderData['time']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (f) => Cart(
                  id: f['id'],
                  title: f['title'],
                  quantity: f['quantity'],
                  price: f['price'],
                  imageUrl: f['imageUrl'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<Cart> cartProducts, double total) async {
    final url =
        'https://shop-app-dc2e5.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final timestamp = DateTime.now();
      final response = await http.post(
        url,
        body: json.encode({
          'amount': total,
          'time': timestamp.toIso8601String(),
          'products': cartProducts
              .map((f) => {
                    'time': f.id,
                    'title': f.title,
                    'quantity': f.quantity,
                    'price': f.price,
                    'imageUrl': f.imageUrl,
                  })
              .toList()
        }),
      );
      _orders.insert(
        0,
        Order(
          id: json.decode(response.body)['name'],
          products: cartProducts,
          amount: total,
          time: timestamp,
        ),
      );
      notifyListeners();
    } catch (e) {}
  }
}
