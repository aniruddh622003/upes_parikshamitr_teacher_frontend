// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void reqApp(BuildContext context) {
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
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: blue,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        textScaler: TextScaler.linear(1),
                        "Request Approved",
                        style: TextStyle(
                            color: white,
                            fontSize: fontLarge,
                            fontWeight: FontWeight.bold)),
                    const Text(
                        textScaler: TextScaler.linear(1),
                        'Your submission has been authenticated by the controller. You can exit this screen!',
                        style: TextStyle(color: white, fontSize: fontMedium)),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            const storage = FlutterSecureStorage();
                            String? jwt = await storage.read(key: 'jwt');
                            await storage.delete(key: "invigilation_state");
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Dashboard(jwt: jwt);
                            }));
                          } catch (e) {
                            errorDialog(context, e.toString());
                          }
                        },
                        child: const Text(
                            textScaler: TextScaler.linear(1), "OK"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
