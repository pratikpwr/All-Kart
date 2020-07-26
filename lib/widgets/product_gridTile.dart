import 'package:all_kart/providers/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);

    final int price = product.price;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed('/product-detail', arguments: product.id);
                },
                child: Image.network(
                  product.imageUrl,
                  height: MediaQuery.of(context).size.height - 570,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Consumer<Product>(
                  builder: (context, product, child) {
                    return IconButton(
                      icon: Icon(product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        product.toggleFavoriteStatus();
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
        Text(
          product.title,
          style: GoogleFonts.titilliumWeb(
              fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          '\$ $price',
          style: GoogleFonts.titilliumWeb(
              fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
