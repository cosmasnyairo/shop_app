import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  final String imageUrl;

  CartItem(
    this.id,
    this.productId,
    this.title,
    this.quantity,
    this.price,
    this.imageUrl,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.endToStart,
      key: ValueKey(id),
      onDismissed: (direction) {
        Provider.of<Carts>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
             shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            title: Text('Alert'),
            elevation: 4,
            content: Text('Do You Want To Remove From Cart?'),
            actions: <Widget>[
              FlatButton(
                child: Row(
                  children: <Widget>[
                    Text('Yes'),
                    Icon(Icons.check),
                  ],
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
              ),
              FlatButton(
                child: Row(
                  children: <Widget>[
                    Text('No'),
                    Icon(Icons.close),
                  ],
                ),
                onPressed: () {
                  Navigator.of(ctx).pop(false);  
                },
              ),
            ],
          ),
        );
      },
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: ClipOval(
                  child: Image.network(
                    imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            title: Text(
              '$title',
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text('Total: \$${(price * quantity)}'),
            trailing: Text('\$$price x $quantity'),
          ),
        ),
      ),
    );
  }
}
