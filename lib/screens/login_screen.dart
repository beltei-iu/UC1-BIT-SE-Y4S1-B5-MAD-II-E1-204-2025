import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mad_2_204/data/app_shared_pref.dart';
import 'package:mad_2_204/route/app_route.dart';
import 'package:mad_2_204/screens/main_screen.dart';
import 'package:mad_2_204/widgets/logo_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isValidMail = false;
  bool _isValidPass = false;
  bool _obscureText = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _body);
  }

  Widget get _body {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoWidget(),
                  SizedBox(height: 16),
                  _email,
                  SizedBox(height: 10),
                  _password,
                  SizedBox(height: 16),
                  _loginButton,
                  SizedBox(height: 16),
                  _socialLogin,
                  SizedBox(height: 16),
                  _skip,
                ],
              ),
            ),
            _navigateToRegister,
          ],
        ),
      ),
    );
  }

  Widget get _email {
    return TextFormField(
      controller: _emailController,
      onChanged: (value) {
        if (value.contains("@")) {
          setState(() {
            _isValidMail = true;
          });
        } else {
          setState(() {
            _isValidMail = false;
          });
        }
      },
      decoration: InputDecoration(
        prefix: Icon(Icons.account_circle),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(20),
        ),
        suffix:
            _isValidMail
                ? Icon(Icons.check_circle, color: Colors.green)
                : Icon(Icons.check_circle),
        hintText: 'Email',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please input email";
        }
        return null;
      },
    );
  }

  Widget get _password {
    return TextFormField(
      controller: _passwordController,
      onChanged:
          (value) => setState(() {
            _isValidPass = value.length >= 6;
          }),
      obscureText: _obscureText,
      decoration: InputDecoration(
        prefix: Icon(Icons.lock_person),
        suffix:
            _obscureText
                ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                  ),
                )
                : Icon(Icons.visibility_off),
        hintText: '******',

        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please input password";
        }
        return null;
      },
    );
  }

  Widget get _loginButton {
    return SizedBox(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            String email = _emailController.text;
            String password = _passwordController.text;
            _signIn(email, password);
          }
        },
        child: Text(
          "Login",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget get _socialLogin {
    return Padding(
      padding: EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/facebook.png", width: 30, height: 30),
          Image.asset("assets/images/google.png", width: 30, height: 30),
        ],
      ),
    );
  }

  Widget get _skip {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              Get.off(MainScreen());
            },
            child: Text("Skip"),
          ),
        ],
      ),
    );
  }

  Widget get _navigateToRegister {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Don't have an account?"),
          TextButton(
            onPressed: () {
              AppRoute.key.currentState!.pushNamed(AppRoute.registerScreen);
            },
            child: Text("Register Now"),
          ),
        ],
      ),
    );
  }

  Future<void> _signIn(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((UserCredential user) {
            print("UserCredential : $user");
            // Navigation to MainScreen
            Get.off(MainScreen());
          })
          .catchError((error) {
            print("catchError : $error");
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("$error")));
          });
    } catch (error) {
      print("catch : $error");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("$error")));
    }
  }
}
