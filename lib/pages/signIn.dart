import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UPES Pariksha Mitr- Teachers',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 17, 0),
            child: Text(
              "Welcome Back.",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 6, 16, 10),
            child: Text(
              "We are happy to assist you again.",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 90),
            child: SvgPicture.asset('android/assets/signinpage.svg'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 15),
            child: CustomTextField(label: 'Enter your sap ID'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 15),
            child: CustomTextField(label: 'Enter your password'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(214, 0, 29, 30),
            child: Text(
              'Forgot Password',
              style: TextStyle(color: Colors.orange, fontSize: 14),
            ),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(25, 15, 25, 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(310, 40),
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
              )),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 30),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(310, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Colors.orange,
                    width: 1.0,
                  ),
                ),
              ),
              onPressed: () {},
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(text: 'Don\'t have an account? '),
                    TextSpan(
                      text: 'Sign Up',
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

class CustomTextField extends StatelessWidget {
  final String label;

  const CustomTextField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: Colors.blue[50],
      ),
    );
  }
}
