import 'package:flutter/material.dart';
import 'package:mad_2_204/data/db_manager.dart';
import 'package:mad_2_204/route/app_route.dart';
import 'package:mad_2_204/screens/home_screen.dart';
import 'package:mad_2_204/screens/main_screen.dart';
import 'package:mad_2_204/screens/splash_screen.dart';

void main() async {
  // Make sure our app's widget initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Init DB
  await DBManager.instance.database;
  //insertProduct();
  runApp(App());
}


Future insertProduct() async {
  final db = await DBManager.instance.database;
  await db.execute("INSERT INTO tbl_product(name, price, quantity) VALUES('CoCaCola',2000,1)");
  await db.execute("INSERT INTO tbl_product(name, price, quantity) VALUES('Water',2000,1)");

  final products = await db.query("tbl_product");
  print(products);
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
