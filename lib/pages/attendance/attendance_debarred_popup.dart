import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void attendanceErrorDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: red,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Not Allowed',
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
                const Text(
                    'Student either has been placed on financial hold or is debarred.',
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
