import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login/home_activity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? const Dashboard() : const HomeActivity(),
    );
  }
}
