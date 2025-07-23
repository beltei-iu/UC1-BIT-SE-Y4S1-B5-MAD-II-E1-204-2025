import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_204/data/file_storage-service.dart';

import '../controllers/cart_controller.dart' show CartController;
import '../models/product.dart' show Product;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  final cartController = Get.put(CartController());
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {

    products = cartController.cartItems;

    return Scaffold(
      appBar: AppBar(title: Text("Cart"),
      centerTitle: true,
      backgroundColor: Colors.indigoAccent),
      body: ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {

        Product product = products[index];

        return Dismissible(
            key: ValueKey(product.id),
            child: Card(
          child: ListTile(
            trailing: Icon(Icons.edit),
            title: Text("${product.id}"),
            leading: Icon(Icons.shopping_cart),
          ),
        ),
        confirmDismiss: (DismissDirection direction) async {
          final alert = AlertDialog(
            title: Icon(Icons.question_mark, color: Colors.red, size: 25,),
            content: Text("Do you want to deleted"),
            actions: [
              ElevatedButton(onPressed: (){
                cartController.removeCart(product);
                Get.back();
                setState(() {
                  products = cartController.cartItems;
                });
              }, child: Text("OK")

              ),
              ElevatedButton(onPressed: (){
                Get.back();
              }, child: Text("Cancel")),
            ],
          );
          showDialog(context: context, builder: (context) => alert);
            });
      },
    )



      // FutureBuilder(
      //   future: FileStorageService.getOrderProducts(),
      //   builder: (
      //     BuildContext context,
      //     AsyncSnapshot<List<String>> asyncSnapshot,
      //   ) {
      //     if (asyncSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //
      //     List<String> data = asyncSnapshot.data as List<String>;
      //
      //     return ListView.builder(
      //       itemCount: data.length,
      //       itemBuilder: (BuildContext context, int index) {
      //         return Card(child: ListTile(title: Text(data[index])));
      //       },
      //     );
      //   },
      // ),
    );
  }
}
