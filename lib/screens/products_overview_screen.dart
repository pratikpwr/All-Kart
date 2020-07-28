import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../widgets/my_appBar.dart';
import 'package:flutter/material.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: Column(
        children: <Widget>[
          MyAppBar(
            title: 'AllKart',
            leading: Icons.menu,
            leadingOnTap: () {
              _key.currentState.openDrawer();
            },
            isCart: true,
          ),
          Expanded(
            child: ProductsGrid(
              isFavoriteOnly: false,
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/favorites');
        },
        child: Icon(
          Icons.favorite,
          size: 36,
        ),
        backgroundColor: const Color(0xff2e2e2d),
      ),
    );
  }
}
