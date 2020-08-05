import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../widgets/badge.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import '../providers/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedItem = Provider.of<Products>(context).findById(productId);
    final cart = Provider.of<Cart>(context);
    Provider.of<Product>(context);
    final authData = Provider.of<Auth>(context, listen: false);

    final double screenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: screenHeight,
        child: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Image.network(
                  loadedItem.imageUrl,
                  height: screenHeight * 0.66,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: screenHeight * 0.42,
                    decoration: BoxDecoration(
                        color: Theme.of(context).canvasColor,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30))),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            loadedItem.title,
                            maxLines: 3,
                            style: GoogleFonts.titilliumWeb(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            loadedItem.description,
                            style: GoogleFonts.titilliumWeb(
                              fontSize: 18,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '₹ ${loadedItem.price}',
                                style: GoogleFonts.titilliumWeb(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () {
                                  cart.addItem(loadedItem.id, loadedItem.title,
                                      loadedItem.price, loadedItem.imageUrl);
                                  Toast.show("Added Item to Cart", context,
                                      duration: Toast.LENGTH_SHORT,
                                      gravity: Toast.BOTTOM);
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 34, vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2e2e2d),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    'Add to Cart',
                                    style: GoogleFonts.titilliumWeb(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(50)),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(50)),
                  child: Badge()),
            ),
            Positioned(
              top: screenHeight * 0.545,
              left: MediaQuery.of(context).size.width - 90,
              child: ChangeNotifierProvider.value(
                value: loadedItem,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff2e2e2d),
                      borderRadius: BorderRadius.circular(50)),
                  child: Consumer<Product>(
                    builder: (context, product, child) {
                      return IconButton(
                        icon: Icon(product.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: () {
                          product.toggleFavoriteStatus(
                              authData.token, authData.userId);
                        },
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
