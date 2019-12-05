import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions{
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
          PopupMenuButton(
            onSelected: (FilterOptions val){
               setState(() {
                  if (val == FilterOptions.Favourites) {
                   _showFavourites= true;
                } 
                else {
                  _showFavourites = false;
                } 
               });
            },
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('My Favourites'), value: FilterOptions.Favourites),
              PopupMenuItem(child: Text('Show All Items'), value: FilterOptions.All),
            ],
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ProductsGrid(_showFavourites),
    );
  }
}
