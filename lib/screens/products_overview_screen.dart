import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../widgets/products_grid.dart';
import '../widgets/badge.dart'; 
import '../widgets/drawer.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductsOverview extends StatefulWidget {
  @override
  _ProductsOverviewState createState() => _ProductsOverviewState();
}

class _ProductsOverviewState extends State<ProductsOverview> {
  var _showFavourites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          Consumer<Carts>(
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('cart-detail');
              },
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions val) {
              setState(() {
                if (val == FilterOptions.Favourites) {
                  _showFavourites = true;
                } else {
                  _showFavourites = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('My Favourites'),
                  value: FilterOptions.Favourites),
              PopupMenuItem(
                  child: Text('Show All Items'), value: FilterOptions.All),
            ],
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavourites),
    );
  }
}
