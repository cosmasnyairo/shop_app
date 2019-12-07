import 'package:flutter/material.dart';

import '../models/cart.dart';
import '../models/order.dart';

class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<Cart> cartProducts, double total) {
    _orders.insert(
      0,
      Order(
        id: DateTime.now().toString(),
        products: cartProducts,
        amount: total,
        time: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
