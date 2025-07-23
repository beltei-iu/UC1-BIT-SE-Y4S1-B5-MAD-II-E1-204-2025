import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_204/data/app_shared_pref.dart';
import 'package:mad_2_204/route/app_route.dart';
import 'package:mad_2_204/screens/language_screen.dart';
import 'package:mad_2_204/screens/theme_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('More'),
        centerTitle: true,
          backgroundColor: Colors.indigoAccent

      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text("language".tr),
            subtitle: Text("${Get.locale?.languageCode == 'en' ? 'englishLanguage'.tr : 'khmerLanguage'.tr}"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(LanguageScreen());
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Theme"),
            subtitle: Text("Light"),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Get.to(ThemeScreen());
            },
          ),
          Divider(),
        ],
      )
    );
  }
}
