// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
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
          Padding(
            padding:
                const EdgeInsets.only(top: 80), // adjust the value as needed
            child: Image.asset('assets/home_art.png'),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 16.0), // adjust the value as needed
            child: Center(
              child: Text('ParikshaMitr',
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                      fontSize: 32,
                      color: orange,
                      fontWeight: FontWeight.w700)),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 40.0), // adjust the value as needed
            child: Center(
              child: Text('Teacher\'s Portal',
                  textScaler: TextScaler.linear(1),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32, color: white, fontWeight: FontWeight.w700)),
            ),
          ),
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
                try {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()));
                } catch (e) {
                  errorDialog(context, e.toString());
                }
              },
              child: const Text(
                'Get Started',
                textScaler: TextScaler.linear(1),
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
            // child: Image.asset(
            //   'assets/upes_logo.png',
            //   width: 150,
            //   height: 80.5,
            // ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
