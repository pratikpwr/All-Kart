import './helper/custom-routes.dart';
import './providers/auth.dart';
import './screens/auth_screen.dart';
import 'screens/splash_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';
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
        ChangeNotifierProvider<Auth>(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => Products(null, null, []),
          update: (_, auth, previousProducts) => Products(
              auth.token,
              auth.userId,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider<Cart>(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider<Product>(
          create: (ctx) => Product(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (ctx) => Orders(null, null, []),
          update: (ctx, auth, previousOrders) => Orders(auth.token, auth.userId,
              previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) {
          return MaterialApp(
            title: 'AllKart',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.android: CustomPageTransitionBuilder(),
                  TargetPlatform.iOS: CustomPageTransitionBuilder()
                }),
                //canvasColor: const Color(0xfff9f9f9)
                canvasColor: const Color(0xffffecf0)),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoSignIn(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              '/product-overview': (context) => ProductOverviewScreen(),
              '/product-detail': (context) => ProductDetailScreen(),
              '/favorites': (context) => FavoritesScreen(),
              '/cart': (context) => CartScreen(),
              '/orders': (context) => OrderScreen(),
              '/userProducts': (context) => UserProductScreen(),
              '/editProducts': (context) => EditProductScreen(),
              '/auth': (context) => AuthScreen(),
            },
          );
        },
      ),
    );
  }
}
