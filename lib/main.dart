import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/order.dart';

import './screens/auth_screen.dart';

import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

import './screens/order_detail_screen.dart';
import '././screens/cart_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';

import './providers/auth_provider.dart';
import './providers/orders_provider.dart';
import './providers/products_provider.dart';
import './providers/cart_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Authenticate()),
        ChangeNotifierProxyProvider<Authenticate, Products>(
          update: (ctx, auth, previousProduct) => Products(
            auth.token,
            previousProduct == null ? [] : previousProduct.items,
          ),
        ),
        //either syntax works
        ChangeNotifierProvider.value(value: Carts()),
        ChangeNotifierProxyProvider<Authenticate, Orders>(
          update: (ctx, auth, previousOrder) => Orders(
            auth.token,
            previousOrder == null ? [] : previousOrder.orders,
          ),
        ),
      ],
      child: Consumer<Authenticate>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Shop App',
          theme: ThemeData(
            primaryColor: Colors.teal,
            accentColor: Colors.deepOrangeAccent,
            fontFamily: 'Lato',
            canvasColor: Color.fromRGBO(180, 215, 219, 1),
          ),
          home: auth.isAuth ? ProductsOverview() : AuthScreen(),
          routes: {
            'product-overview': (ctx) => ProductsOverview(),
            'product-detail': (ctx) => ProductsDetail(),
            'cart-detail': (ctx) => CartDetail(),
            'order-detail': (ctx) => OrderDetail(),
            'manage-products': (ctx) => UserProducts(),
            'edit-products': (ctx) => EditProductScreen(),
          },
        ),
      ),
    );
  }
}
