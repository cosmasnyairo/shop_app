import 'package:flutter/material.dart';


class ProductsDetail extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    final productId= ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text('title'),),
    );
  }
}