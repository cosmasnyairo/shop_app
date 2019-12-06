import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../widgets/cart_item.dart';
import '../providers/cart_provider.dart';

class CartDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Carts>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('A'),
      ),
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
                      '\$ ${cart.totalAmount}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.title.color),
                    ),
                  ),
                  FlatButton(
                    child: Text('COMPLETE ORDER!'),
                    textColor: Theme.of(context).accentColor,
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('You have ${cart.itemCount} items in your cart.'),
          Expanded(
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (ctx, i) => CartItem(),
            ),
          )
        ],
      ),
    );
  }
}
