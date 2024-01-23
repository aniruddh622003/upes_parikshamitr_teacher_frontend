import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/password_field.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login/signin_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/custom_text_field.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});
  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double minHeight = screenHeight - appBarHeight - statusBarHeight;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text(
          'UPES Pariksha Mitr - Teachers',
          style: TextStyle(
            fontSize: fontMedium,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
        backgroundColor: blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Container(
            constraints: BoxConstraints(minHeight: minHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 20, 17, 0),
                      child: Text(
                        "Welcome to",
                        style: TextStyle(
                          fontSize: fontXLarge,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 17, 12),
                      child: Text(
                        "Pariksha Mitr",
                        style: TextStyle(
                            color: blue,
                            fontSize: fontXLarge,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      height: 2,
                      width: 330,
                      color: blue,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 11, 16, 20),
                      child: Text(
                        "Let's help you manage examinations.",
                        style: TextStyle(
                          color: grayDark,
                          fontSize: fontMedium,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                      child: CustomTextField(label: 'Enter your name'),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                      child: CustomTextField(label: 'Enter your SAP ID'),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                      child: PasswordField(label: 'Password'),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: PasswordField(label: 'Re-type Password'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            minimumSize: const Size(310, 40),
                            backgroundColor: blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Dashboard()));
                          },
                          child: const Text(
                            'Register',
                            style: TextStyle(
                                color: white,
                                fontSize: fontMedium,
                                fontWeight: FontWeight.w800),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: const Size(310, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: orange,
                              width: 1.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()));
                        },
                        child: RichText(
                          text: const TextSpan(
                            style: TextStyle(
                              color: black,
                              fontSize: fontSmall,
                            ),
                            children: [
                              TextSpan(text: 'Already a User? '),
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(
                                    color: orange, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
