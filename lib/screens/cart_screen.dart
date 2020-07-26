import '../widgets/my_appBar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          MyAppBar(
            title: 'Cart',
            leading: Icons.arrow_back,
            leadingOnTap: () {
              Navigator.pop(context);
            },
            isCart: false,
          ),
          Center(
            child: Text('Add to Cart'),
          )
        ],
      ),
    );
  }
}
