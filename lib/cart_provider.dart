// cart_provider.dart
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List<String> _items = [];

  List<String> get items => _items;

  int get cartCount => _items.length;

  void addToCart() {
    _items.add('Item');
    notifyListeners();
  }
}
