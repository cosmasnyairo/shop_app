import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  UserProductItem(this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
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
                    Navigator.of(context).pushNamed('edit-products');
                  },
                  color: Theme.of(context).primaryColor,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {},
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
