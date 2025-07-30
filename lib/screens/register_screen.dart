import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mad_2_204/route/app_route.dart';
import 'package:mad_2_204/screens/login_screen.dart';
import 'package:mad_2_204/widgets/logo_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isValidMail = false;

  final TextEditingController _fullNameController = TextEditingController();
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
                  _fullName,
                  SizedBox(height: 16),
                  _email,
                  SizedBox(height: 16),
                  _password,
                  SizedBox(height: 16),
                  _loginButton,
                  SizedBox(height: 16),
                  _socialLogin,
                ],
              ),
            ),
            _navigateToLogin,
          ],
        ),
      ),
    );
  }

  Widget get _fullName {
    return TextFormField(
      controller: _fullNameController,
      decoration: InputDecoration(
        prefix: Icon(Icons.account_circle),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: 'Full Name',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please input full name";
        }
        return null;
      },
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
      decoration: InputDecoration(
        prefix: Icon(Icons.lock_person),
        suffix: Icon(Icons.check_circle),
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
            _register(email, password);
          }
        },
        child: Text(
          "Register",
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

  Widget get _navigateToLogin {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Already have an account?"),
          TextButton(
            onPressed: () {
              AppRoute.key.currentState!.pushNamed(AppRoute.loginScreen);
            },
            child: Text("Login"),
          ),
        ],
      ),
    );
  }

  Future<void> _register(String email, String password) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((UserCredential user) {
            print("UserCredential : $user");
            // Navigation to LoginScreen
            Get.to(LoginScreen());
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
