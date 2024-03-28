// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/custom_text_field.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';
// import 'package:upes_parikshamitr_teacher_frontend/pages/forgot_password/forgot_password_base.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login/login_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/password_field.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final storage = const FlutterSecureStorage();
  Future<void> sendPostRequest(Map<String, dynamic> data) async {
    var url = Uri.parse('$serverUrl/teacher/login');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        await storage.write(
            key: 'jwt', value: jsonDecode(response.body)['token']);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Dashboard(jwt: jsonDecode(response.body)['token'])));
      } else {
        errorDialog(context,
            '${jsonDecode(response.body)['message']}. Please try again.');
      }
    } catch (e) {
      errorDialog(context, 'Registration Failed! $e');
    }
  }

  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();

  Future<void>? _futurePostRequest;

  @override
  void dispose() {
    // controllerEmail.dispose();
    // controllerPass.dispose();
    super.dispose();
  }

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
          textScaler: TextScaler.linear(1),
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
            try {
              Navigator.pop(context);
            } catch (e) {
              errorDialog(context, e.toString());
            }
          },
        ),
      ),
      resizeToAvoidBottomInset: true,
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
                        "Welcome Back.",
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                          fontSize: fontXLarge,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 6, 16, 10),
                      child: Text(
                        textScaler: TextScaler.linear(1),
                        "We are happy to assist you again.",
                        style: TextStyle(
                          color: grayDark,
                          fontSize: fontMedium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 90),
                      child: SvgPicture.asset('android/assets/signinpage.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                      child: CustomTextField(
                        label: 'Enter your SAP ID',
                        controller: controllerEmail,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                      child: PasswordField(
                        label: 'Enter your password',
                        controller: controllerPass,
                      ),
                    ),
                    // Padding(
                    //     padding: const EdgeInsets.fromLTRB(214, 0, 29, 0),
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //                 builder: (context) =>
                    //                     const ForgotPassword()));
                    //       },
                    //       child: const Text(
                    //         'Forgot Password',
                    //textScaler: const TextScaler.linear(1),
                    //         style:
                    //             TextStyle(color: orange, fontSize: fontSmall),
                    //       ),
                    //     )),
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
                            try {
                              if (controllerEmail.text.isEmpty ||
                                  controllerPass.text.isEmpty) {
                                errorDialog(
                                    context, 'Please fill all the fields.');
                              } else {
                                Map<String, dynamic> data = {
                                  'sap_id': int.parse(controllerEmail.text),
                                  'password': controllerPass.text,
                                };
                                setState(() {
                                  _futurePostRequest = sendPostRequest(data);
                                });
                              }
                            } catch (e) {
                              errorDialog(context, e.toString());
                            }
                          },
                          child: FutureBuilder<void>(
                            future: _futurePostRequest,
                            builder: (BuildContext context,
                                AsyncSnapshot<void> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator(
                                  color: white,
                                );
                              } else {
                                return const Text(
                                  'Sign In',
                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(
                                      color: white,
                                      fontSize: fontMedium,
                                      fontWeight: FontWeight.w800),
                                );
                              }
                            },
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
                          try {
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LogInPage()));
                          } catch (e) {
                            errorDialog(context, e.toString());
                          }
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
          )
        ],
      ),
    );
  }
}
