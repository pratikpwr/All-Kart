import 'dart:convert';
import '../providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OrderItem {
  final String id;
  final int amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({this.id, this.amount, this.products, this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrder() async {
    const url = 'https://allkart-6ac4e.firebaseio.com/orders.json';
    try {
      final response = await http.get(url);
      final extractedOrder = json.decode(response.body) as Map<String, dynamic>;
      final List<OrderItem> loadedOrders = [];
      if (extractedOrder == null) {
        return;
      }
      extractedOrder.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map((e) => CartItem(
                    price: e['price'],
                    imageUrl: e['imageUrl'],
                    title: e['title'],
                    id: e['id'],
                    quantity: e['quantity']))
                .toList()));
      });
      //print(json.decode(response.body));
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addOrder(List<CartItem> cartItem, int total) async {
    const url = 'https://allkart-6ac4e.firebaseio.com/orders.json';
    final timeStamp = DateTime.now();

    final response = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartItem
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'imageUrl': e.imageUrl,
                    'price': e.price,
                    'quantity': e.quantity
                  })
              .toList()
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            dateTime: timeStamp,
            products: cartItem));

    notifyListeners();
  }
}
