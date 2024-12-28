import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  double get totalPrice {
    return _items.fold(
        0.0, (sum, item) => sum + (item["price"] * item["quantity"]));
  }

  void addItem(String name, double price, int quantity, {String? imageUrl}) {
    final index = _items.indexWhere((item) => item["name"] == name);
    if (index >= 0) {
      _items[index]["quantity"] += quantity;
      if (_items[index]["quantity"] <= 0) {
        _items.removeAt(index);
      }
    } else {
      _items.add({
        "name": name,
        "price": price,
        "quantity": quantity,
        "imageUrl": imageUrl ?? '' // imageUrl boşsa boş string olarak ekle
      });
    }
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  void removeItem(String name) {
    _items.removeWhere((item) => item["name"] == name);
    notifyListeners();
  }
}
