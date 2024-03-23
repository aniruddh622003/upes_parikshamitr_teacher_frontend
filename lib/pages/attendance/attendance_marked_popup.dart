import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void attendancePresentErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: green,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Present',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                            fontSize: fontMedium,
                            color: white,
                            fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close_sharp,
                        color: white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Student has already been marked as present.',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      fontSize: fontMedium,
                      color: white,
                    )),
              ],
            ),
          );
        },
      );
    },
  );
}
