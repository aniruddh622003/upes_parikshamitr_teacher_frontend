import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/signIn.dart';
import 'pages/homeActivity.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeActivity(),
      // isSignedIn ? Dashboard() : const HomeActivity(),
    );
  }
}
