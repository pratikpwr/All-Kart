import '../providers/orders.dart';
import '../widgets/app_drawer.dart';
import '../widgets/my_appBar.dart';
import '../widgets/order_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    GlobalKey<ScaffoldState> _key = GlobalKey();
    return Scaffold(
      key: _key,
      drawer: AppDrawer(),
      body: Column(
        children: <Widget>[
          MyAppBar(
            title: 'Your Orders',
            leading: Icons.menu,
            leadingOnTap: () {
              _key.currentState.openDrawer();
            },
            isCart: false,
          ),
          orderData.orders.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(
                      'No Orders',
                      style: GoogleFonts.titilliumWeb(fontSize: 28),
                    ),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                  itemCount: orderData.orders.length,
                  itemBuilder: (context, index) {
                    return OrderItemTile(orderData.orders[index]);
                  },
                ))
        ],
      ),
    );
  }
}
