import 'package:all_kart/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Badge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/cart');
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              }),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.all(2.0),
              // color: Theme.of(context).accentColor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).accentColor,
              ),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Consumer<Cart>(
                builder: (_, cart, child) {
                  return Text(
                    cart.itemCount.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
