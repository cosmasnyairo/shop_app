import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import './screens/cart_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';

import './providers/products_provider.dart';
import './providers/cart_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Products()),
        ChangeNotifierProvider(create: (ctx) => Carts()),
      ],
      child: MaterialApp(
        title: 'Shop App',
        theme: ThemeData(
          primaryColor: Colors.teal,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Lato',
          canvasColor: Color.fromRGBO(180, 215, 219, 1),
        ),
        home: ProductsOverview(),
        routes: {
          'product-detail': (ctx) => ProductsDetail(),
          'cart-detail': (ctx) => CartDetail(),
        },
      ),
    );
  }
}
