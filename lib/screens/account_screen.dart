import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_204/services/firebase_auth_service.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String _fullName = "Guest";
  String _email = "";
  String _phoneNumber = "";
  String _imageUrl = "";

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final user = await FirebaseAuth.instance.currentUser!;
    print("User from Gogole ${user}");
    print("User from Gogole ${user.photoURL}");
    setState(() {
      _fullName = user.displayName ?? "Guest";
      _email = user.email ?? "";
      _phoneNumber = user.phoneNumber ?? "";
      _imageUrl = user.photoURL ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account", style: TextStyle(color: Colors.white)),
        elevation: 0.2,
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_imageUrl),
                ),
                Divider(),
                ListTile(
                  title: Text("Full Name"),
                  subtitle: Text("$_fullName"),
                ),
                Divider(),
                ListTile(title: Text("Email"), subtitle: Text("$_email")),
                Divider(),
                ListTile(
                  title: Text("Phone Number"),
                  subtitle: Text("$_phoneNumber"),
                ),
                Divider(),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 32),
            child: SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                ),
                onPressed: () {
                  FirebaseAuthService.instance.logout();
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
}
