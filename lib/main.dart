import './providers/cart.dart';
import './providers/orders.dart';
import './providers/product.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/favorites_screen.dart';
import './providers/products.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider<Product>(
          create: (ctx) => Product(),
        ),
        ChangeNotifierProvider<Orders>(
          create: (ctx) => Orders(),
        )
      ],
      child: MaterialApp(
        title: 'AllKart',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            //canvasColor: const Color(0xfff9f9f9)
            canvasColor: const Color(0xffffecf0)),
        initialRoute: '/',
        routes: {
          '/': (context) => ProductOverviewScreen(),
          '/product-detail': (context) => ProductDetailScreen(),
          '/favorites': (context) => FavoritesScreen(),
          '/cart': (context) => CartScreen(),
          '/orders': (context) => OrderScreen(),
        },
      ),
    );
  }
}
