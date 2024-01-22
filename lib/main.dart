import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/home_activity.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/invigilator_dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: InvigilatorDashboard()
        // isSignedIn ? Dashboard() : const HomeActivity(),
        );
  }
}
