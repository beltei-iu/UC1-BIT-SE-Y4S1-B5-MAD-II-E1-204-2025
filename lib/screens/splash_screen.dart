import 'package:flutter/material.dart';
import 'package:mad_2_204/route/app_route.dart';
import 'package:mad_2_204/widgets/logo_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWidget(),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  //Navigator.pushNamed(context, AppRoute.mainScreen);
                  AppRoute.key.currentState?.pushNamed(AppRoute.loginScreen);
                },
                child: Text("Get Start", style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.mainScreen);
                },
                child: Text("As Guest", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
