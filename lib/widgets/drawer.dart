import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Shop App'),
            automaticallyImplyLeading: false,
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.shop,
              size: 28,
            ),
            title: Text(
              'Shop',
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('product-overview');
            },
          ),
          ListTile(
            leading: Icon(
              Icons.payment,
              size: 28,
            ),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('order-detail');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.my_location,
              size: 28,
            ),
            title: Text('Manage Products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('manage-products');
            },
          ),
          Spacer(),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              size: 28,
            ),
            title: Text('Sign Out'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Authenticate>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
