// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login/home_activity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool verified = false;

  Future<void> verifyToken({required String token}) async {
    var response = await http.get(
      Uri.parse('$serverUrl/teacher/verifyLogin'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      verified = true;
    }
  }

  const storage = FlutterSecureStorage();
  String? jwt = await storage.read(key: 'jwt');
  if (jwt != null) {
    await verifyToken(token: jwt);
  }
  runApp(MyApp(jwt: jwt, verified: verified));
}

class MyApp extends StatelessWidget {
  final String? jwt;
  final bool verified;
  const MyApp({super.key, required this.jwt, required this.verified});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          jwt != null && verified ? Dashboard(jwt: jwt) : const HomeActivity(),
    );
  }
}
