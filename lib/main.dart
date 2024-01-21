import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_page.dart';
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
      home: Test(),
      // isSignedIn ? Dashboard() : const HomeActivity(),
    );
  }
}
