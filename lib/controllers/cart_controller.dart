
import 'package:get/get.dart';

import '../models/product.dart' show Product;

class CartController extends GetxController {

  List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  Future<List<Product>> getCart() async {
    return _cartItems;
  }

  Future<void> addCart(Product product) async {
    print("Product : ${product.id}");
    _cartItems.add(product);
    print("_cartItems ${_cartItems.length}");
  }

  Future<void> removeCart(Product product) async {
    _cartItems.remove(product);
  }
}