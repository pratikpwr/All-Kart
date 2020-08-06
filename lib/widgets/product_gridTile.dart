import '../providers/auth.dart';

import '../providers/product.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductGridTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final authData = Provider.of<Auth>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  child: Hero(
                    tag: product.id,
                    child: FadeInImage(
                      placeholder:
                          AssetImage('assets/images/product-placeholder.png'),
                      image: NetworkImage(product.imageUrl),
                      height: MediaQuery.of(context).size.height - 595,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  )),
              Align(
                alignment: Alignment.topRight,
                child: Consumer<Product>(
                  builder: (context, product, child) {
                    return IconButton(
                      icon: Icon(product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        product.toggleFavoriteStatus(
                            authData.token, authData.userId);
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
          '₹ ${product.price}',
          style: GoogleFonts.titilliumWeb(
              fontSize: 20, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
