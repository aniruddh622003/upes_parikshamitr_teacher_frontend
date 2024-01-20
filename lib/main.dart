import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/seating_arrangement.dart';
// import 'package:upes_parikshamitr_teacher_frontend/pages/signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SeatingArrangement(),
      // isSignedIn ? Dashboard() : const HomeActivity(),
    );
  }
}
