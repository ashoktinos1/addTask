import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject1/views/bottom_nav_page/home.dart';
import 'package:myproject1/views/login/login_screen.dart';

class AuthCheck extends StatelessWidget {
  AuthCheck({Key? key}) : super(key: key);
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      return Home();
    } else {
      return LoginPage();
    }
  }
}
