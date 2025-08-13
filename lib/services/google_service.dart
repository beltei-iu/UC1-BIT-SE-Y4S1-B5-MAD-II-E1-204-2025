import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mad_2_204/screens/main_screen.dart';

class GoogleService {
  static GoogleService _instance = GoogleService._init();

  static GoogleService get instance => _instance;

  GoogleService._init();

  Future<void> signInWithGoogle() async {
    try {
      // Get SignIn trigger
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // Get SignIn auth
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      print("Google Auth accessToken : ${googleAuth.accessToken}");

      // SignIn with Firebase by Google Provider
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // SignIn with Firebase Auth
      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      // Both Facebook and Google
      userCredential.user?.updatePhotoURL(googleUser.photoUrl);
      Get.offAll(MainScreen());
    } catch (error) {
      print("Error : $error");
      Get.snackbar("Error", "$error");
    }
  }

  Future<bool> isGoogleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    return googleAuth.accessToken != null;
  }

  Future<void> signOutGoogle() async {
    await GoogleSignIn().signOut();
  }
}
