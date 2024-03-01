import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/req_app.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void pendingReq(BuildContext context) {
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
                color: orange,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Pending Request",
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                            color: white,
                            fontSize: fontLarge,
                            fontWeight: FontWeight.bold)),
                    const Text(
                        'Your submission has been sent for authentication to the controller. Kindly wait!',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(color: white, fontSize: fontMedium)),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          reqApp(context);
                        },
                        child: const Text(
                          "OK",
                          textScaler: TextScaler.linear(1),
                        ),
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
