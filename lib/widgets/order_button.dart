import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders_provider.dart';
import '../providers/cart_provider.dart';

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Carts cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading
          ? CircularProgressIndicator(
              strokeWidth: 4,
            )
          : Text('COMPLETE ORDER!'),
      textColor: Theme.of(context).accentColor,
      onPressed: widget.cart.items.isNotEmpty || _isLoading
          ? () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );

              setState(() {
                _isLoading = false;
              });
              widget.cart.clearCart();
              Navigator.of(context).pushReplacementNamed('order-detail');
            }
          : null,
    );
  }
}
