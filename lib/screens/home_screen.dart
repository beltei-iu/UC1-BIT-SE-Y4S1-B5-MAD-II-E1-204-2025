import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mad_2_204/controllers/cart_controller.dart';
import 'package:mad_2_204/data/file_storage-service.dart';
import 'package:mad_2_204/models/product.dart';
import 'package:mad_2_204/provider/cart_provider.dart';
import 'package:mad_2_204/services/product_service.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import 'package:flutter/services.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = 'Guest';
  int _totalOrderProduct = 0;
  List<Product> _products = [];
  bool _isLoading = false;
  final cartController = Get.put(CartController());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _loadUser();
    _getFriends();
  }

  Future<void> _loadOrderProduct() async {
    // Load from File
    // List<String> productsOrder = await FileStorageService.getOrderProducts();
    // setState(() {
    //   _totalOrderProduct = productsOrder.length;
    // });
    // Load from DB
    final productService = ProductService();
    setState(() {
      _isLoading = true;
    });
    List<Product> products = await productService.getProducts();
    print("Product Items : ${products.length}");
    //await Future.delayed(Duration(seconds: 5));
    setState(() {
      _isLoading = false;
    });
    setState(() {
      _products = products;
    });
  }

  Future<void> _loadUser() async {
    final User? user = await _auth.currentUser;
    setState(() {
      userName = user!.email?.split("@")[0] ?? 'Guest';
    });
  }

  Future<void> _getFriends() async {
    final token = await FacebookAuth.instance.accessToken;
    final response = await http.get(
      Uri.parse(
        'https://graph.facebook.com/v12.0/me/friends?access_token=${token!.tokenString}',
      ),
    );
    print('Friends: ${response.body}');
  }

  @override
  Widget build(BuildContext context) {
    // Provider
    //final cartProvider = Provider.of<CartProvider>(context, listen:true);
    // Add to Card
    // setState(() {
    //   _totalOrderProduct = cartProvider.cartItems.length;
    // });

    setState(() {
      _totalOrderProduct = cartController.cartItems.length;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'hi'.tr + " $userName",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        elevation: 0.5,
        actions: [
          Icon(Icons.search),
          badges.Badge(
            position: badges.BadgePosition.topEnd(top: 10, end: 10),
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
            badgeContent: Text(
              "$_totalOrderProduct",
              style: TextStyle(color: Colors.white),
            ),
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {},
            ),
          ),

          Icon(Icons.more_vert),
        ],
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _search,
          _slider,
          _recommentPlaceWidget,
          _placeListWidget,
          _topProductsWidget,
          _productListWidget,
        ],
      ),
    );
  }

  Widget get _slider {
    return Image.asset(
      'assets/images/HQ.png',
      fit: BoxFit.cover,
      width: double.infinity,
      height: 200,
    );
  }

  Widget get _search {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Search',
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }

  Widget get _recommentPlaceWidget {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "recommended".tr,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("seeAll".tr, style: TextStyle(fontSize: 16, color: Colors.blue)),
        ],
      ),
    );
  }

  Widget get _placeListWidget {
    _products = List.generate(10, (i) => Product()).toList();

    final cartItems2 =
        _products.map((e) {
          return SizedBox(
            height: 150,
            child: Card(
              child: Image.asset(
                "assets/images/img1.png",
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          );
        }).toList();

    setState(() {
      _isLoading = false;
    });

    final cartItems = List.generate(10, (item) {
      return SizedBox(
        height: 150,
        child: Card(
          child: Image.asset(
            "assets/images/img1.png",
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      );
    });

    //return Row(children: cartItems);

    // Option 1 : ListView
    // return Padding(
    //   padding: EdgeInsets.only(left: 8, right: 8),
    //   child: SizedBox(
    //     height: 200,
    //     child: ListView(children: cartItems, scrollDirection: Axis.horizontal),
    //   ),
    // );

    // Option 2 : SingleChildScrollView + Row

    Widget productItems =
        _isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(children: cartItems2),
              ),
            );

    return productItems;
  }

  Widget get _topProductsWidget {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Top Products",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("See All", style: TextStyle(fontSize: 16, color: Colors.blue)),
        ],
      ),
    );
  }

  Widget get _productListWidget {
    _products = List.generate(10, (i) => Product()).toList();
    List<Widget> cartItems =
        _products.map((item) {
          return SizedBox(
            height: 200,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/product1.png",
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          //FileStorageService.orderProduct(item.id!, 200, 1, 10);

                          // GetX
                          final product = Product(id: item.id!);
                          cartController.addCart(product);

                          final alert = AlertDialog(
                            title: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 25,
                            ),
                            content: Text("Order Added successfully"),
                            actions: [
                              TextButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                            context: context,
                            builder: (context) => alert,
                          );
                        },
                        child: Text(
                          "+",
                          style: TextStyle(fontSize: 18, color: Colors.red),
                        ),
                      ),
                      Text("1", style: TextStyle(fontSize: 24)),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          "-",
                          style: TextStyle(fontSize: 24, color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList();

    //return Row(children: cartItems);

    // Option 1 : ListView
    // return Padding(
    //   padding: EdgeInsets.only(left: 8, right: 8),
    //   child: SizedBox(
    //     height: 200,
    //     child: ListView(children: cartItems, scrollDirection: Axis.horizontal),
    //   ),
    // );

    // Option 2 : SingleChildScrollView + Row
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Row(children: cartItems),
      ),
    );
  }
}
