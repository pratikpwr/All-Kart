import '../providers/product.dart';
import '../providers/products.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class UserProductTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loadedProduct = Provider.of<Product>(context);
    return Dismissible(
      key: ValueKey(loadedProduct.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Products>(context, listen: false)
            .deleteProduct(loadedProduct.id);
        Toast.show("Product Deleted", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      },
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to Delete the Product?'),
                backgroundColor: Theme.of(context).canvasColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text('No')),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text('Yes')),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 5,
              child: Container(
                height: 90,
                width: MediaQuery.of(context).size.width - 35,
                padding: EdgeInsets.all(10),
                decoration: new BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        2.0,
                        2.0,
                      ),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          loadedProduct.title,
                          style: GoogleFonts.titilliumWeb(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              '₹ ${loadedProduct.price}',
                              style: GoogleFonts.titilliumWeb(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/editProducts',
                              arguments: loadedProduct.id);
                        })
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
                  loadedProduct.imageUrl,
                  height: 100,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
