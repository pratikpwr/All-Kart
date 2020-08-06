import 'dart:math';
import '../providers/orders.dart';
import '../widgets/order_expanded_tile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class OrderItemTile extends StatefulWidget {
  final OrderItem orderItem;

  OrderItemTile(this.orderItem);

  @override
  _OrderItemTileState createState() => _OrderItemTileState();
}

class _OrderItemTileState extends State<OrderItemTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _expanded
          ? min(widget.orderItem.products.length * 20.0 + 220, 390)
          : 100,
      child: Card(
        elevation: 10,
        color: Theme.of(context).canvasColor,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            ListTile(
              title: (Text(
                '₹ ${widget.orderItem.amount}',
                style: GoogleFonts.titilliumWeb(
                    fontSize: 22, fontWeight: FontWeight.bold),
              )),
              subtitle: Text(
                DateFormat('dd/MM/yyyy  hh:mm')
                    .format(widget.orderItem.dateTime),
                style: GoogleFonts.titilliumWeb(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  icon: _expanded
                      ? Icon(Icons.expand_less)
                      : Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  }),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _expanded
                  ? min(widget.orderItem.products.length * 20.0 + 130, 300)
                  : 0,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: widget.orderItem.products.length,
                  itemBuilder: (context, index) {
                    return ChangeNotifierProvider.value(
                        value: widget.orderItem.products.toList()[index],
                        child: OrderExpandedTile());
                  }),
            )
          ],
        ),
      ),
    );
  }
}
