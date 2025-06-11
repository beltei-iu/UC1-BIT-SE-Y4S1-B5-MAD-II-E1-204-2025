import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = 'Guest';

  @override
  void initState() {
    super.initState();
    _loadUser();
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
      body: ListView(children: [_search, _slider]),
    );
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
      title: Text(
        'Hi, $userName',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      elevation: 0.5,
      actions: [Icon(Icons.search), Icon(Icons.more_vert)],
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
}
