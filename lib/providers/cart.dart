import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final int price;

  CartItem({this.id, this.title, this.quantity, this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items ={};

  Map<String, CartItem> get items => {..._items};

  int get itemCount{
    return _items.length;
  }
  void addItem(String productId, String title, int price) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCardItem) => CartItem(
              id: existingCardItem.id,
              title: existingCardItem.title,
              price: existingCardItem.price,
              quantity: existingCardItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              title: title,
              id: DateTime.now().toString(),
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }
}
