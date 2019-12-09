import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final scaffold= Scaffold.of(context);
    return Container(
      height: 80,
      child: Card(
        elevation: 1,
        margin: EdgeInsets.all(6),
        child: ListTile(
          title: Text(title),
          leading: ClipOval(
            child: Image.network(
              imageUrl,
              width: 60,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
          trailing: Container(
            width: 100,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed('edit-products', arguments: id);
                  },
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    try {
                      scaffold.showSnackBar(
                        SnackBar(
                          content: Text('Deleted', textAlign: TextAlign.center,),
                        ),
                      );
                      await Provider.of<Products>(context, listen: false)
                          .deleteProduct(id);
                     
                    } catch (e) {
                      scaffold.showSnackBar(
                        SnackBar(
                          content: Text('Deleting Failed. Try Again', textAlign: TextAlign.center,),
                        ),
                      );
                    }
                  },
                  color: Theme.of(context).errorColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
