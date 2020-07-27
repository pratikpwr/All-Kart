import 'package:flutter/foundation.dart';

class CartItem with ChangeNotifier {
  final String id;
  final String title;
  final int quantity;
  final int price;
  final String imageUrl;

  CartItem({this.id, this.title, this.quantity, this.price, this.imageUrl});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount {
    return _items.length;
  }

  int get cartTotal {
    var total = 0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, String title, int price, String imageUrl) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCardItem) => CartItem(
              id: existingCardItem.id,
              title: existingCardItem.title,
              price: existingCardItem.price,
              imageUrl: existingCardItem.imageUrl,
              quantity: existingCardItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              title: title,
              id: productId,
              price: price,
              imageUrl: imageUrl,
              quantity: 1));
    }

    notifyListeners();
  }

  void removeItem (String productId){
    _items.remove(productId);
    notifyListeners();
  }
}
