import 'package:google_fonts/google_fonts.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/product_gridTile.dart';
import 'package:flutter/material.dart';

class ProductsGrid extends StatelessWidget {
  final bool isFavoriteOnly;

  ProductsGrid({this.isFavoriteOnly});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = isFavoriteOnly ? productData.favorites : productData.items;

    return products.isEmpty
        ? Center(
            child: Text(
              'Add Products to Favorite First',
              style: GoogleFonts.titilliumWeb(fontSize: 20),
            ),
          )
        : GridView.builder(
            itemCount: products.length,
            padding: const EdgeInsets.all(25),
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
                crossAxisSpacing: 20,
                mainAxisSpacing: 8),
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: products[index],
                child: ProductGridTile(),
              );
            },
          );
  }
}
