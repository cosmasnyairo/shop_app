import 'package:flutter/foundation.dart';

import '../models/cart.dart';

class Cart with ChangeNotifier{
  Map<String, CartItem> _items;
  
  Map<String, CartItem> get items{
    return {..._items};
  }

  void addItem(String id, double price, String title, String imageUrl){
      if (_items.containsKey(id)) {
        _items.update(id, (exist) => CartItem(
          id: exist.id,
          title: exist.id,
          price: exist.price,
          quantity: exist.quantity+1,
          imageUrl: exist.imageUrl,
        ) );
      }
       else {
         //add new
         _items.putIfAbsent(id, ()=> CartItem(
            id: DateTime.now().toString(),
            title: title,
            price:price,
            quantity: 1,
            imageUrl: imageUrl,

         ));
      }
  }
}