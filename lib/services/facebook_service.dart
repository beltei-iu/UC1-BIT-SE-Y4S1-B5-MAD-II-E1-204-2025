import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:mad_2_204/screens/main_screen.dart';

class FacebookService {
  static FacebookService _instance = FacebookService._init();

  static FacebookService get instance => _instance;

  FacebookService._init();

  Future<void> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(
        result.accessToken!.tokenString,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("Data Response : ${result.accessToken!.tokenString}");
      // Navigation to MainScreen
      Get.offAll(MainScreen());
    } else {
      print(result.message);
      Get.snackbar("Error", "${result.message}");
    }
  }

  Future<bool> isFacebookSignIn() async {
    AccessToken? accessToken = await FacebookAuth.instance.accessToken;
    return accessToken != null;
  }

  Future<void> signOutFacebook() async {
    await FacebookAuth.instance.logOut();
  }
}
