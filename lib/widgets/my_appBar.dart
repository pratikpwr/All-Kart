import '../widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyAppBar extends StatelessWidget {
  final String title;
  final IconData leading;
  final Function leadingOnTap;
  bool isCart;

  MyAppBar({this.title, this.leading, this.leadingOnTap, this.isCart = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        color: Theme.of(context).canvasColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 20.0,
            spreadRadius: 1.0,
            offset: Offset(
              3.0,
              3.0,
            ),
          )
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(leading),
                  onPressed: leadingOnTap,
                ),
                Text(
                  title,
                  style: GoogleFonts.titilliumWeb(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                isCart ? Badge() : Text('            '),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
