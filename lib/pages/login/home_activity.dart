// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login/signin_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/upes_logo.png'),
          const Text('ParikshaMitr',
              style: TextStyle(
                  fontSize: 40, color: white, fontWeight: FontWeight.w400)),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(300, 40),
                backgroundColor: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInPage()));
              },
              child: const Text(
                'Get Started',
                style: TextStyle(
                    color: black,
                    fontSize: fontMedium,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "UPES ParikshaMitr - Teachers",
              style: TextStyle(fontSize: fontSmall, color: white),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
