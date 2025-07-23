
import 'package:flutter/material.dart';
import 'package:mad_2_204/models/product.dart';

class CartProvider extends ChangeNotifier {

  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  Future<void> addCart(Product product) async{
    _cartItems.add(product);
    notifyListeners();
  }


}