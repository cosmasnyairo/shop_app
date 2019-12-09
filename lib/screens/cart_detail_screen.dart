import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/drawer.dart';

import '../widgets/cart_item.dart';
import '../widgets/order_button.dart';

import '../providers/cart_provider.dart';
class CartDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Carts>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$ ${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.title.color),
                    ),
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('You have ${cart.itemCount} items in your cart.'),
          cart.items.isEmpty
              ? SizedBox(
                  height: 10,
                )
              : Text(
                  'Swipe right to remove an item from the cart',
                  style: TextStyle(color: Colors.grey),
                ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].imageUrl,
              ),
            ),
          ),
          cart.items.isNotEmpty
              ? RaisedButton(
                  child: Text('Clear Cart!'),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Provider.of<Carts>(context, listen: false).clearCart();
                  },
                )
              : SizedBox(
                  height: 10,
                )
        ],
      ),
    );
  }
}
