import '../providers/cart.dart';
import '../providers/orders.dart';
import '../screens/orders_screen.dart';
import '../widgets/cart_item_tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../widgets/my_appBar.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      body: Column(
        children: <Widget>[
          MyAppBar(
            title: 'Your Cart',
            leading: Icons.arrow_back,
            leadingOnTap: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            isCart: false,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 210,
                child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                          value: cart.items.values.toList()[index],
                          child: CartItemTile());
                    }),
              ),
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 20.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        3.0,
                        3.0,
                      ),
                    ),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 58, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total',
                            style: GoogleFonts.titilliumWeb(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹ ${cart.cartTotal}',
                            style: GoogleFonts.titilliumWeb(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    OrderButton(cart: cart),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.cart.items.isEmpty
          ? () {
              Toast.show("Add Items to Cart First", context,
                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
            }
          : () async {
              setState(() {
                isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.cartTotal);
              setState(() {
                isLoading = false;
              });
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => OrderScreen()),
                ModalRoute.withName('/orders'),
              );
              widget.cart.clearCart();
            },
      child: isLoading
          ? CircularProgressIndicator()
          : Container(
              height: 56,
              width: 240,
              decoration: BoxDecoration(
                color: const Color(0xff2e2e2d),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                child: Text(
                  'Order  Now',
                  style: GoogleFonts.titilliumWeb(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
    );
  }
}
