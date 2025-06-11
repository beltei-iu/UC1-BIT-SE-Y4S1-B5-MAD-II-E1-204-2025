import 'package:flutter/material.dart';
import 'package:mad_2_204/data/file_storage-service.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadOrderProduct();
  }

  Future<void> _loadOrderProduct() async {
    List<String> productsOrder = await FileStorageService.getOrderProducts();
    setState(() {
      _totalOrderProduct = productsOrder.length;
    });
  }

  Future<void> _loadUser() async {
    final sharedPref = await SharedPreferences.getInstance();
    final fullName = sharedPref.getString('fullName');
    final email = sharedPref.getString('email');
    print('Full Name: $fullName'); // Debugging line to check the value

    Future.delayed(const Duration(seconds: 1), () {
      print('User loaded after delay');
    });

    setState(() {
      userName = fullName ?? email ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
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

  PreferredSizeWidget get _appBar {
    return AppBar(
      title: Text(
        'Hi, $userName',
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
          child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
        ),

        Icon(Icons.more_vert),
      ],
      backgroundColor: Colors.white,
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
            "Recommended",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text("See All", style: TextStyle(fontSize: 16, color: Colors.blue)),
        ],
      ),
    );
  }

  Widget get _placeListWidget {
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Row(children: cartItems),
      ),
    );
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
    final cartItems = List.generate(10, (item) {
      return SizedBox(
        height: 150,
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
                      FileStorageService.orderProduct(item, 200, 1, 10);
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
                      showDialog(context: context, builder: (context) => alert);
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: Row(children: cartItems),
      ),
    );
  }
}
