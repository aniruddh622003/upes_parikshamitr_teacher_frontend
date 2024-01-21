import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/doubt_section/doubt_section.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/home_activity.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/placeholder.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/notification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DoubtSection(roomNumber: "11014"),
      // isSignedIn ? Dashboard() : const HomeActivity(),
    );
  }
}
