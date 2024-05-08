// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/check_room_status.dart';

import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';

import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SubmissionDetails extends StatelessWidget {
  const SubmissionDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text(
          'Submission Details',
          textScaler: TextScaler.linear(1),
          style: TextStyle(
            color: white,
          ),
        ),
        backgroundColor: blue,
        elevation: 0,
      ),
      backgroundColor: blue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            shrinkWrap: true,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Submission Recieved",
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                              fontSize: fontLarge,
                              fontWeight: FontWeight.bold,
                              color: orange)),
                      const SizedBox(height: 20),
                      const Center(
                          child: Text(
                              'Your submission has been sent for authentication to the controller. Kindly wait.',
                              textScaler: TextScaler.linear(1),
                              style: TextStyle(fontSize: fontMedium))),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              const storage = FlutterSecureStorage();
                              final String? roomId =
                                  await storage.read(key: 'roomId');
                              dynamic response =
                                  await checkRoomStatus(roomId.toString());
                              if (response.statusCode == 200) {
                                if (jsonDecode(response.body)['data'] ==
                                    "APPROVAL") {
                                  errorDialog(
                                      context, "Kindly wait for approval");
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Submission Approved!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: white,
                                      textColor: black,
                                      fontSize: 16.0);

                                  const storage = FlutterSecureStorage();

                                  // Read and store 'jwt' and 'notifications'
                                  String? jwt = await storage.read(key: 'jwt');
                                  String? notifications =
                                      await storage.read(key: 'notifications');

                                  // Delete all data
                                  await storage.deleteAll();

                                  // Write back 'jwt' and 'notifications' if they were not null
                                  if (jwt != null) {
                                    await storage.write(key: 'jwt', value: jwt);
                                  }
                                  if (notifications != null) {
                                    await storage.write(
                                        key: 'notifications',
                                        value: notifications);
                                  }
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(jwt: jwt),
                                    ),
                                  );
                                }
                              } else {
                                errorDialog(context,
                                    "Submission not yet approved by the controller. Please wait.");
                              }
                            } catch (e) {
                              errorDialog(context, e.toString());
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: orange,
                            foregroundColor: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Check Status',
                            textScaler: TextScaler.linear(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
