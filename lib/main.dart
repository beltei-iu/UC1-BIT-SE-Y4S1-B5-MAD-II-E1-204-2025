import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_204/firebase_options.dart';
import 'package:mad_2_204/route/app_route.dart';
import 'package:mad_2_204/screens/home_screen.dart';
import 'package:mad_2_204/translate/message.dart';

void main() async {
  // Make sure our app's widget initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase Configure
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final homeScreen = HomeScreen();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MAD-II-204',
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
