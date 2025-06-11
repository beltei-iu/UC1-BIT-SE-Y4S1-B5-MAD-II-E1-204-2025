import 'package:flutter/material.dart';
import 'package:mad_2_204/data/file_storage-service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: FutureBuilder(
        future: FileStorageService.getOrderProducts(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<String>> asyncSnapshot,
        ) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          List<String> data = asyncSnapshot.data as List<String>;

          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(child: ListTile(title: Text(data[index])));
            },
          );
        },
      ),
    );
  }
}
