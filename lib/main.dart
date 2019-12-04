import 'package:flutter/material.dart';
import './screens/products_overview_screen.dart';
import 'screens/product_detail_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
        canvasColor: Color.fromRGBO(180, 215, 219, 1),
      ),
      home: ProductsOverview(),
      routes: {
        'product-detail': (ctx) => ProductsDetail(),
      },
    );
  }
}
