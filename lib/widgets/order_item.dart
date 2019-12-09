import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import '../models/order.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.Order order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text('Total :\$ ${widget.order.amount.toStringAsFixed(2)}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy hh:mm').format(widget.order.time),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              padding: EdgeInsets.all(15),
              height: min(widget.order.products.length * 20.0 + 100, 180),
              child: ListView(
                children: widget.order.products
                    .map((f) => Row(
                          children: <Widget>[
                            ClipOval(
                              child: Image.network(
                                f.imageUrl,
                                width: 50,
                                height: 50,
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              f.title,
                              style: TextStyle(fontSize: 14),
                            ),
                            Spacer(),
                            Text(
                              '${f.price} x \$ ${f.quantity}',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}
