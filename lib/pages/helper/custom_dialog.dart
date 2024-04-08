import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void customDialog(BuildContext context, String title, String body) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
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
                    Text(title,
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(
                            fontSize: fontLarge, fontWeight: FontWeight.bold)),
                    Text(body,
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(fontSize: fontMedium)),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          try {
                            Navigator.pop(context);
                          } catch (e) {
                            errorDialog(context, e.toString());
                          }
                        },
                        child:
                            const Text("OK", textScaler: TextScaler.linear(1)),
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
  });
}
