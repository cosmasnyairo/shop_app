import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../providers/products_provider.dart';
import '../widgets/products_grid.dart';

enum FilterOptions{
  Favourites,
  All,
}

class ProductsOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions val){
                if (val == FilterOptions.Favourites) {
                  productsData.showFavourites();
                } 
                else {
                  productsData.showAll();
                }
            },
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('My Favourites'), value: FilterOptions.Favourites),
              PopupMenuItem(child: Text('Show All Items'), value: FilterOptions.All),
            ],
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ProductsGrid(),
    );
  }
}
