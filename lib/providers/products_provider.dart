import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'BicycooBMX Balance Bikes',
      description:
          'The Joovy BicycooBMX is a durable, well designed balance bike for kids 18 months and above. The frame is made of aluminum so it is strong and lightweight just like high-end bikes. The lightweight frame makes controlling the bike much easier for kids, unlike the heavy wooden and steel versions. The tires are pneumatic (air) and refillable. Many balance bikes on the market use EVA plastic tires which are cheaper and wear out much quicker than these rubber tires used on the Joovy BicycooBMX. The suspension qualities of pneumatic tires give kids a much smoother ride',
      price: 99.99,
      imageUrl:
          'https://cdn11.bigcommerce.com/s-f3rn5p/images/stencil/1280x1280/products/1307/8300/Blue_BicycooBmx__69183.1452198661.jpg?c=2&imbypass=on',
    ),
    Product(
      id: 'p2',
      title: 'Joovy Bicycoo Balance Bike',
      description:
          'Introducing the Joovy Bicycoo Balance Bike — the pedal-free bike designed to build balance and coordination naturally, without the training wheels. The Bicycoo is designed to be sturdy and just like a real bike, but easy for your child to maneuver as they develop their coordination and muscle memory. Designed to promote independence and natural muscle development, the Bicycoo requires almost no assembly and is suitable for any child that can walk on their own. Build their confidence and their balance in the same step with the Bicycoo Balance Bike',
      price: 119.99,
      imageUrl:
          'https://cdn11.bigcommerce.com/s-f3rn5p/images/stencil/1280x1280/products/1314/8292/00151_Red_Bicycoo_Rt_Front__02364.1452198338.jpg?c=2&imbypass=on',
    ),
    Product(
      id: 'p3',
      title: 'KooperX2',
      description:
          'There are about a dozen tri-fold strollers out there, but none of them that will rock your socks as much as the KooperX2. With a compact three-part fold and seats for two kids up to 50 lbs each, the KooperX2 double stroller is easy to travel with, and makes traveling easier.',
      price: 49.99,
      imageUrl:
          'https://cdn11.bigcommerce.com/s-f3rn5p/images/stencil/1280x1280/products/1942/9225/X2_Glacier__53257.1548705426.jpg?c=2&imbypass=on',
    ),
    Product(
      id: 'p4',
      title: 'Caboose S',
      description:
          'Independent toddlers and newborns can make a mom feel like she’s being split in two, which is why we designed a stroller that they’re both going to love. Give boisterous big kids a safe place to sit when they’re ready and a snug seat when they’re not with the Caboose S sit and stand stroller',
      price: 29.99,
      imageUrl:
          'https://cdn11.bigcommerce.com/s-f3rn5p/images/stencil/1280x1280/products/1907/8738/Caboose_S_Grey__47567.1521819592.jpg?c=2&imbypass=on',
    ),
    Product(
      id: 'p5',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p6',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p8',
      title: 'Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  List<Product> get items {
    return [..._items];
  }

  List<Product> get favourites {
    return _items.where((test) => test.isFavourite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((p) => p.id == id);
  }

  void addProducts(Product prod) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: prod.title,
      description: prod.description,
      price: prod.price,
      imageUrl: prod.imageUrl,
    );
    _items.add(newProduct);
    notifyListeners();
  } 
}
