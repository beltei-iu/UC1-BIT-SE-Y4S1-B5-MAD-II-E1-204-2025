import 'package:flutter/material.dart';
import 'package:mad_2_204/route/app_route.dart';
import 'package:mad_2_204/screens/home_screen.dart';
import 'package:mad_2_204/screens/main_screen.dart';
import 'package:mad_2_204/screens/splash_screen.dart';

void main() {
  // Make sure our app's widget initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final homeScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAD-II-204',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      // Option 1
      //home: SplashScreen(),

      // Option 2
      // routes: {

      // },
      // Option 3
      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,
    );
  }
}
