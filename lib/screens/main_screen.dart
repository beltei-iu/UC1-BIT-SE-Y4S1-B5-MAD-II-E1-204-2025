import 'package:flutter/material.dart';
import 'package:mad_2_204/screens/cart_screen.dart';
import 'package:mad_2_204/screens/favorite_screen.dart';
import 'package:mad_2_204/screens/home_screen.dart';
import 'package:mad_2_204/screens/more_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Widget> screenList = [
    HomeScreen(),
    FavoriteScreen(),
    CartScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body, bottomNavigationBar: _bottomNav);
  }

  Widget get _body {
    //return screenList.elementAt(_currentIndex);
    return screenList[_currentIndex];
  }

  Widget get _bottomNav {
    final items = [
      BottomNavigationBarItem(
          icon: Icon(Icons.home), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
      BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
      BottomNavigationBarItem(icon: Icon(Icons.more_vert), label: 'More'),
    ];
    return BottomNavigationBar(
      backgroundColor: Colors.indigoAccent,
      items: items,
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.blueGrey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      currentIndex: _currentIndex,
      elevation: 5,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
