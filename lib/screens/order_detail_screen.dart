import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/drawer.dart';

import '../providers/orders_provider.dart';

class OrderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrder(),
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                //presence of error
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('An Error Occured'),
                      Icon(Icons.sentiment_satisfied),
                    ],
                  ),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, order, child) => ListView.builder(
                    itemCount: order.orders.length,
                    itemBuilder: (ctx, i) => OrderItem(order.orders[i]),
                  ),
                );
              }
            }
          }),
    );
  }
}
