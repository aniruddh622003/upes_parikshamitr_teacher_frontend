import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/password_field.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/signIn.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UPES Pariksha Mitr- Teachers',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 17, 0),
            child: Text(
              "Welcome to",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 17, 12),
            child: Text(
              "Pariksha Mitr",
              style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 32,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 2,
            width: 330,
            color: Colors.blue[700],
            margin: const EdgeInsets.symmetric(horizontal: 15),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 11, 16, 30),
            child: Text(
              "Let's help you manage examinations.",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 15),
            child: CustomTextField(label: 'Enter your name'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 15),
            child: CustomTextField(label: 'Enter your SAP ID'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 15),
            child: PasswordField(label: 'Password'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: PasswordField(label: 'Re-type Password'),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(25, 60, 25, 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(310, 40),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Dashboard()));
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: const Size(310, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(
                    color: Colors.orange,
                    width: 1.0,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignIn()));
              },
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(text: 'Already a User? '),
                    TextSpan(
                      text: 'Sign In',
                      style: TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
