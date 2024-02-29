// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/password_field.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login/signin_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/custom_text_field.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPass1 = TextEditingController();
  final TextEditingController controllerPass2 = TextEditingController();

  Future<bool> _registerFuture = Future.value(false);
  Future<bool> sendPostRequest(Map<String, dynamic> data) async {
    var url = Uri.parse('$serverUrl/teacher');
    try {
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                  insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            textScaler: TextScaler.linear(1),
                            "Info",
                            style: TextStyle(
                                fontSize: fontLarge,
                                fontWeight: FontWeight.bold)),
                        Text(
                            textScaler: const TextScaler.linear(1),
                            "${jsonDecode(response.body)['message']}. Please continue to LogIn.",
                            style: const TextStyle(fontSize: fontMedium)),
                        const SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SignInPage()));
                            },
                            child: const Text(
                                textScaler: TextScaler.linear(1), "OK"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
        return true;
      } else {
        errorDialog(context,
            'Registration Failed! ${jsonDecode(response.body)['message']}');
        return false;
      }
    } catch (e) {
      errorDialog(context, 'Registration Failed! $e');
      return false;
    }
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
                        textScaler: TextScaler.linear(1),
                        "Welcome to",
                        style: TextStyle(
                          fontSize: fontXLarge,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 17, 12),
                      child: Text(
                        textScaler: TextScaler.linear(1),
                        "Pariksha Mitr",
                        style: TextStyle(
                            color: blue,
                            fontSize: fontXLarge,
                            fontWeight: FontWeight.w700),
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
                        textScaler: TextScaler.linear(1),
                        "Let's help you manage examinations.",
                        style: TextStyle(
                          color: grayDark,
                          fontSize: fontMedium,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                      child: CustomTextField(
                        label: 'Enter your name',
                        controller: controllerName,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.deny(RegExp('[0-9]')),
                        ],
                      ),
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
                        label: 'Password',
                        controller: controllerPass1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: PasswordField(
                        label: 'Re-type Password',
                        controller: controllerPass2,
                      ),
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
                            if (controllerName.text.isEmpty ||
                                controllerEmail.text.isEmpty ||
                                controllerPass1.text.isEmpty ||
                                controllerPass2.text.isEmpty) {
                              errorDialog(
                                  context, 'Please fill all the fields.');
                            } else if (controllerPass1.text.length < 8) {
                              errorDialog(context,
                                  'Password must be atleast 8 characters long.');
                            } else if (controllerPass1.text.contains(' ')) {
                              errorDialog(
                                  context, 'Password cannot contain spaces.');
                            } else if (controllerPass1.text !=
                                controllerPass2.text) {
                              errorDialog(context, 'Passwords do not match.');
                            } else {
                              // send data to server
                              Map<String, dynamic> data = {
                                'sap_id': int.parse(controllerEmail.text),
                                'name': controllerName.text,
                                'password': controllerPass1.text,
                              };
                              setState(() {
                                _registerFuture = sendPostRequest(data);
                              });
                            }
                          },
                          child: FutureBuilder<bool>(
                            future: _registerFuture,
                            builder: (BuildContext context,
                                AsyncSnapshot<bool> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator(
                                  color: white,
                                );
                              } else {
                                return const Text(
                                  textScaler: TextScaler.linear(1),
                                  'Register',
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
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()));
                        },
                        child: RichText(
                          textScaler: const TextScaler.linear(1),
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
