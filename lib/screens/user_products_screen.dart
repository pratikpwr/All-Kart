import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/my_appBar.dart';
import '../widgets/user_product_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/userProducts';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _key = GlobalKey();
    return Scaffold(
      key: _key,
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/editProducts');
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
        backgroundColor: const Color(0xff2e2e2d),
      ),
      body: Column(
        children: <Widget>[
          MyAppBar(
            title: 'Your Products',
            leading: Icons.menu,
            leadingOnTap: () {
              _key.currentState.openDrawer();
            },
            isCart: false,
          ),
          Expanded(
              child: FutureBuilder(
            future: _refreshProducts(context),
            builder: (ctx, snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => _refreshProducts(context),
                        child: Consumer<Products>(
                          builder: (ctx, productData, _) => ListView.builder(
                              itemCount: productData.items.length,
                              itemBuilder: (context, index) {
                                return ChangeNotifierProvider.value(
                                    value: productData.items[index],
                                    child: UserProductTile());
                              }),
                        ),
                      ),
          ))
        ],
      ),
    );
  }
}
