import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Text(
          "Name",
          style: TextStyle(fontSize: 40, color: Colors.red),
        ),
      ),
    ));
  }
}
