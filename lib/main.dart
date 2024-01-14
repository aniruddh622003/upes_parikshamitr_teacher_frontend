import 'package:flutter/material.dart';
// import 'pages/loginPage.dart';
// import 'pages/signIn.dart';
import 'pages/homeActivity.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: SignIn(),
      // home: LoginPage(),
      home: HomeActivity(),
    );
  }
}
