import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../models/order.dart';

const url = 'https://shop-app-dc2e5.firebaseio.com/orders.json';

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void fetchOrder() {}

  void addOrder(List<Cart> cartProducts, double total) async {
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'products' : cartProducts ,
          'amount': total,
          'time': DateTime.now(),
        }),
      );
      _orders.insert(
        0,
        Order(
          id: json.decode(response.body)['name'],
          products: cartProducts,
          amount: total,
          time: DateTime.now(),
        ),
      );
      notifyListeners();
    } catch (e) {}
  }
}
