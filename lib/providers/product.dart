import 'package:flutter/material.dart';

class Product extends ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int price;
  bool isFavorite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.imageUrl,
      this.price,
      this.isFavorite = false});

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
