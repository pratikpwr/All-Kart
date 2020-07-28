import '../providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OrderExpandedTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<CartItem>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 5,
            child: Container(
              height: 90,
              width: MediaQuery.of(context).size.width - 75,
              padding: EdgeInsets.all(10),
              decoration: new BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15.0,
                    spreadRadius: 0.5,
                    offset: Offset(
                      1.0,
                      1.0,
                    ),
                  )
                ],
              ),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 90,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        cartItem.title,
                        style: GoogleFonts.titilliumWeb(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '₹ ${cartItem.price}',
                            style: GoogleFonts.titilliumWeb(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'X  ${cartItem.quantity}',
                            style: GoogleFonts.titilliumWeb(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15.0,
                  spreadRadius: 1.0,
                  offset: Offset(
                    3.0,
                    3.0,
                  ),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              child: Image.network(
                cartItem.imageUrl,
                height: 100,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
