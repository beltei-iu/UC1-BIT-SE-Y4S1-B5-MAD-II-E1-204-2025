import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:mad_2_204/screens/login_screen.dart';
import 'package:mad_2_204/services/facebook_service.dart';
import 'package:mad_2_204/services/google_service.dart';

class FirebaseAuthService {
  static FirebaseAuthService _instance = FirebaseAuthService._init();

  static FirebaseAuthService get instance => _instance;

  FirebaseAuthService._init();

  Future<bool> isFirebaseSignIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await FacebookService.instance.signOutFacebook();
    await GoogleService.instance.signOutGoogle();
    Get.to(LoginScreen());
  }
}
