// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
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
                    const Text("Request Approved",
                        style: TextStyle(
                            color: white,
                            fontSize: fontLarge,
                            fontWeight: FontWeight.bold)),
                    const Text(
                        'Your submission has been authenticated by the controller. You can exit this screen!',
                        style: TextStyle(color: white, fontSize: fontMedium)),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          const storage = FlutterSecureStorage();
                          String? jwt = await storage.read(key: 'jwt');
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Dashboard(jwt: jwt);
                          }));
                        },
                        child: const Text("OK"),
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
