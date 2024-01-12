import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
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
              "Welcome to",
              style: TextStyle(
                fontSize: 32,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 0, 17, 12),
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
            margin: EdgeInsets.symmetric(horizontal: 15),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15, 11, 16, 30),
            child: Text(
              "Let's help you manage examinations.",
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 0, 25, 15),
            child: CustomTextField(label: 'Enter your name'),
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
            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: CustomTextField(label: 'Re-enter your password'),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(25, 60, 25, 10),
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
                  'Register',
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
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: Colors.blue[50],
      ),
    );
  }
}
