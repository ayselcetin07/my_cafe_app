import 'package:flutter/material.dart';
import 'menuItem.dart';

class Cart with ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  double get totalPrice => _items.fold(
      0, (total, current) => total + current['price'] * current['quantity']);

  void addItem(MenuItem menuItem, int quantity) {
    final index = _items.indexWhere((item) => item['name'] == menuItem.name);
    if (index >= 0) {
      _items[index]['quantity'] += quantity;
    } else {
      _items.add({
        'name': menuItem.name,
        'price': menuItem.price,
        'quantity': quantity,
        'imageUrl': menuItem.imageUrl,
      });
    }
    notifyListeners();
  }

  void removeItem(String name) {
    _items.removeWhere((item) => item['name'] == name);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
