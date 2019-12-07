import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/order_item.dart';
import '../widgets/drawer.dart';

import '../providers/orders_provider.dart';

class OrderDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final order= Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: order.orders.length,
        itemBuilder: (ctx , i) => OrderItem(order.orders[i]),
      )
    );
  }
}
