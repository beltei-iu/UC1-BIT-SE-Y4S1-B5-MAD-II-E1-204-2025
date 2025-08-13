import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  static FirebaseAuthService _instance = FirebaseAuthService._init();

  static FirebaseAuthService get instance => _instance;

  FirebaseAuthService._init();

  Future<bool> isFirebaseSignIn() async {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
