import '../providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 80,
            margin: EdgeInsets.only(left: 16),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Text(
                  'Hello Friend',
                  style: GoogleFonts.titilliumWeb(
                      fontWeight: FontWeight.bold, fontSize: 24),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.shopping_basket),
            title: Text(
              'Shop',
              style: GoogleFonts.titilliumWeb(
                  fontWeight: FontWeight.w600, fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/product-overview');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Your Orders',
              style: GoogleFonts.titilliumWeb(
                  fontWeight: FontWeight.w600, fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/orders');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.category),
            title: Text(
              'Your Products',
              style: GoogleFonts.titilliumWeb(
                  fontWeight: FontWeight.w600, fontSize: 18),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/userProducts');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'SignOut',
              style: GoogleFonts.titilliumWeb(
                  fontWeight: FontWeight.w600, fontSize: 18),
            ),
            onTap: () {
              Provider.of<Auth>(context, listen: false).signOut();
              Navigator.pushReplacementNamed(context, '/auth');
            },
          )
        ],
      ),
    );
  }
}
