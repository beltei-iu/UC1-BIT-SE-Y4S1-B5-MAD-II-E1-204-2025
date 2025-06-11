import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16, top: 16),
      child: Image.asset(
        "assets/images/beltei_international_university_in_cambodia.png",
        width: 200,
        height: 200,
      ),
    );
  }
}
