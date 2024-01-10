import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_details.dart';
// import 'package:upes_parikshamitr_teacher_frontend/pages/dashboard.dart';
// import 'package:upes_parikshamitr_teacher_frontend/pages/start_invigilation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 63, 255),
      ),
      home: const InvigilationDetails(),
    );
  }
}
