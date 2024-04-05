// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/update_phone_email.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/custom_text_field.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/valid_email_checker.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class CheckPhoneEmail extends StatefulWidget {
  const CheckPhoneEmail({super.key});

  @override
  State<CheckPhoneEmail> createState() => _CheckPhoneEmailState();
}

class _CheckPhoneEmailState extends State<CheckPhoneEmail> {
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();

  @override
  void dispose() {
    // controllerPhone.dispose();
    // controllerEmail.dispose();
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
        ),
        resizeToAvoidBottomInset: true,
        body: ListView(children: [
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
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: fontXLarge,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 17, 12),
                          child: Text(
                            "Pariksha Mitr",
                            textScaler: TextScaler.linear(1),
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
                            "Please update the details to continue.",
                            textScaler: TextScaler.linear(1),
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
                            label: 'Enter phone number',
                            controller: controllerPhone,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                          child: CustomTextField(
                            label: 'Enter email',
                            controller: controllerEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
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
                            onPressed: () async {
                              try {
                                if (controllerPhone.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Please enter your phone number.')),
                                  );
                                } else if (controllerPhone.text.length != 10) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Invalid Phone Number.')),
                                  );
                                } else if (!isValidEmail(
                                    controllerEmail.text)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Invalid Email Address.')),
                                  );
                                } else {
                                  // Handle the phone number and email here
                                  // Use the updatePhoneEmail function from the API;
                                  var data = {
                                    'phone': controllerPhone.text,
                                    'email': controllerEmail.text,
                                  };
                                  var response = await updatePhoneEmail(data);

                                  if (response.statusCode == 200) {
                                    // Show a toast message
                                    Fluttertoast.showToast(
                                        msg: "Update successful.",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 3,
                                        backgroundColor: white,
                                        textColor: black,
                                        fontSize: 16.0);

                                    const storage = FlutterSecureStorage();
                                    final String? jwt =
                                        await storage.read(key: 'jwt');
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard(
                                                jwt: jwt,
                                              )),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text(
                                              'Failed to update phone and email.')),
                                    );
                                  }
                                }
                              } catch (e) {
                                errorDialog(context, e.toString());
                              }
                            },
                            child: const Text(
                              'Update Details',
                              style: TextStyle(
                                  color: white,
                                  fontSize: fontMedium,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]))
        ]));
  }
}
