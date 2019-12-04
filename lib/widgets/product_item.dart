import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

 class ProductItem extends StatelessWidget {
//   final String id;
//   final String title;

//   final String imageUrl;
//   ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final product= Provider.of<Product>(context);
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
            icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_border ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              product.toggleFavourite();
            },
          ),
          title: Text(
            product.title,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
