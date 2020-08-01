import '../providers/orders.dart';
import '../widgets/app_drawer.dart';
import '../widgets/my_appBar.dart';
import '../widgets/order_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    //final orderData = Provider.of<Orders>(context);
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
          FutureBuilder(
            future:
                Provider.of<Orders>(context, listen: false).fetchAndSetOrder(),
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (dataSnapshot.error != null) {
                return Expanded(
                  child: Center(
                    child: Text(
                      'An error occurred',
                      style: GoogleFonts.titilliumWeb(fontSize: 28),
                    ),
                  ),
                );
              } else {
                return Expanded(child: Consumer<Orders>(
                  builder: (ctx, orderData, child) {
                    return orderData.orders.isEmpty
                        ? Center(
                            child: Text(
                              'No Orders',
                              style: GoogleFonts.titilliumWeb(fontSize: 28),
                            ),
                          )
                        : ListView.builder(
                            itemCount: orderData.orders.length,
                            itemBuilder: (context, index) {
                              return OrderItemTile(orderData.orders[index]);
                            },
                          );
                  },
                ));
              }
            },
          )
        ],
      ),
    );
  }
}
