import '../widgets/my_appBar.dart';
import '../widgets/products_grid.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          MyAppBar(
            title: 'Favorites',
            leading: Icons.arrow_back,
            leadingOnTap: () {
              Navigator.pop(context);
            },
            isCart: true,
          ),
          Expanded(
            child: ProductsGrid(
              isFavoriteOnly: true,
            ),
          ),
        ],
      ),
    );
  }
}
