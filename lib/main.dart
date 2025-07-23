import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_204/data/db_manager.dart';
import 'package:mad_2_204/provider/cart_provider.dart';
import 'package:mad_2_204/route/app_route.dart';
import 'package:mad_2_204/screens/home_screen.dart';
import 'package:mad_2_204/screens/main_screen.dart';
import 'package:mad_2_204/screens/splash_screen.dart';
import 'package:mad_2_204/translate/message.dart';
import 'package:provider/provider.dart';

void main() async {
  // Make sure our app's widget initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Init DB
  // await DBManager.instance.database;
  //insertProduct();
  runApp(App());

  // final provider = MultiProvider(
  //     providers: [
  //       ChangeNotifierProvider(create: (_) => CartProvider()),
  //       //
  //     ],
  //     child: App()
  // );
  // runApp(provider);
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
    //return MaterialApp(
      return GetMaterialApp(
      title: 'MAD-II-204',
      // theme: ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      // ),

      initialRoute: AppRoute.splashScreen,
      onGenerateRoute: AppRoute.onGenerateRoute,
      navigatorKey: AppRoute.key,


        // Localization
        translations: Message(),
        locale: Get.deviceLocale,

        // Theme
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,

    );
  }
}
