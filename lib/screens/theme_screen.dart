import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({super.key});

  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    _isDark = Get.isDarkMode ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("theme".tr),
        centerTitle: true,
        elevation: 0.5,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          ListTile(
            title: Text("light".tr),
            leading: Icon(Icons.light_mode),
            trailing: Checkbox(
              value: !_isDark,
              onChanged: (v) {
                Get.changeTheme(ThemeData.light());
                setState(() {
                  _isDark = false;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text("dark".tr),
            leading: Icon(Icons.dark_mode),
            trailing: Checkbox(
              value: _isDark,
              onChanged: (v) {
                Get.changeTheme(ThemeData.dark());
                setState(() {
                  _isDark = true;
                });
              },
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
