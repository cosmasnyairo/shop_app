import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

import '../providers/cart_provider.dart';
import '../models/product.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Carts>(context);
    final authData = Provider.of<Authenticate>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              'product-detail',
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(
              product.isFavourite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              if (!product.isFavourite) {
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added to Favourites'),
                    duration: Duration(seconds: 4),
                  ),
                );
              } else {
                Scaffold.of(context).removeCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Removed from Favourites'),
                    duration: Duration(seconds: 4),
                  ),
                );
              }
              product.toggleFavourite(authData.token, authData.userId);
            },
          ),
          title: Text(
            product.title,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          trailing:
              //Consumer<Product>(
              //   //rebuilds this part only
              //   builder: (ctx, product, child) =>
              IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(
                product.id,
                product.price,
                product.title,
                product.imageUrl,
              );
              Scaffold.of(context).removeCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Item Added to Cart',
                  ),
                  duration: Duration(
                    seconds: 4,
                  ),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
