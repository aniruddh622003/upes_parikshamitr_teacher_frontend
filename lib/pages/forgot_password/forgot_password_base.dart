import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/forgot_password/forgot_password_status_widget.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login/login_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
            textScaler: TextScaler.linear(1),
            'UPES Pariksha Mitr - Teachers',
            style: TextStyle(
              fontSize: fontMedium,
              fontWeight: FontWeight.bold,
              color: white,
            ),
          ),
          backgroundColor: blue,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
            // physics: ClampingScrollPhysics(),
            child: SizedBox(
                height: minHeight,
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        const Expanded(child: ForgotPasswordProgressTrack()),
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            textScaler: TextScaler.linear(1),
                            'OR',
                            style: TextStyle(
                              fontSize: fontLarge,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              minimumSize: const Size(double.infinity, 40),
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
                                      builder: (context) => const LogInPage()));
                            },
                            child: RichText(
                              textScaler: const TextScaler.linear(1),
                              text: const TextSpan(
                                style: TextStyle(
                                  color: black,
                                  fontSize: fontSmall,
                                ),
                                children: [
                                  TextSpan(text: 'Don\'t have an account? '),
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                        color: orange,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ))
                  ],
                ))));
  }
}
