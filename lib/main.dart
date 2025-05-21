import 'package:flutter/material.dart';
import 'package:mad_2_204/screens/home_screen.dart';

void main() {
  // Make sure our app's widget initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final homeScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD-II-204',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: homeScreen,
    );
  }
}
