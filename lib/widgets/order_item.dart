import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';


class OrderItem extends StatelessWidget {
  final Order order;
  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(
              DateFormat('dd MM yyyy  hh:mm').format(order.time),
            ),
            trailing: Icon(Icons.expand_more),
          )
        ],
      ),
    );
  }
}
