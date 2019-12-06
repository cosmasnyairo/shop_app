import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../providers/cart_provider.dart';

class ProductsDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final cart= Provider.of<Carts>(context);

    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<Products>(context).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: Image.network(loadedProduct.imageUrl),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
                cart.addItem(loadedProduct.id, loadedProduct.price, loadedProduct.title, loadedProduct.imageUrl);  
              },
      ),
    );
  }
}
