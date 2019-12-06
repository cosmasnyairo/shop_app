import 'package:flutter/foundation.dart';

import '../models/cart.dart';

class Carts with ChangeNotifier {
  Map<String, Cart> _items = {};

  Map<String, Cart> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, a) {
      total += a.price * a.quantity;
    });
    return total;
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void addItem(String id, double price, String title, String imageUrl) {
    if (_items.containsKey(id)) {
      _items.update(
          id,
          (exist) => Cart(
                id: exist.id,
                title: exist.id,
                price: exist.price,
                quantity: exist.quantity + 1,
                imageUrl: exist.imageUrl,
              ));
    } else {
      //add new
      _items.putIfAbsent(
        id,
        () => Cart(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantity: 1,
            imageUrl: imageUrl),
      );
    }
    notifyListeners();
  }
}
