import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_204/data/app_shared_pref.dart';
import 'package:mad_2_204/route/app_route.dart';
import 'package:mad_2_204/screens/language_screen.dart';
import 'package:mad_2_204/screens/login_screen.dart';
import 'package:mad_2_204/screens/theme_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _fullName = "Guest";

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final User? user = await _auth.currentUser;
    setState(() {
      _fullName = user!.email?.split("@")[0] ?? 'Guest';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: const Text('More'),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text("language".tr),
                  subtitle: Text(
                    "${Get.locale?.languageCode == 'en' ? 'englishLanguage'.tr : 'khmerLanguage'.tr}",
                  ),
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
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text("Profile"),
                  subtitle: Text("$_fullName"),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                Divider(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                ),
                onPressed: () {
                  _logout();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Logout", style: TextStyle(color: Colors.white)),
                    SizedBox(width: 4),
                    Icon(Icons.logout, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _logout() async {
    try {
      await _auth.signOut();
      Get.to(LoginScreen());
    } catch (error) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("$error")));
    }
  }
}
