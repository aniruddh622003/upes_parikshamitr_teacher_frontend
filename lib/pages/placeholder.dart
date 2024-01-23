import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/pending_supplies_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';

class Test extends StatelessWidget {
  const Test({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          GestureDetector(
            onTap: () => attendancePopup(context),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
