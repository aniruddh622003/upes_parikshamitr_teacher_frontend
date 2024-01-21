import 'dart:math';

import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void seatingPlanPopup(
    BuildContext context, Map<String, Object> studentDetails) {
  Color eligibleColor;
  String eligibleText = "";
  if (studentDetails['eligible'] == 'YES') {
    eligibleColor = green;
    eligibleText = "YES";
  } else if (studentDetails['eligible'] == 'F_HOLD') {
    eligibleColor = yellow;
    eligibleText = "NO (FINANCIAL HOLD)";
  } else if (studentDetails['eligible'] == 'DEBARRED') {
    eligibleColor = red;
    eligibleText = "NO (Debarred)";
  } else {
    eligibleColor = grayDark;
    eligibleText = "NO";
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Student Details',
                      style: TextStyle(
                          fontSize: fontMedium, fontWeight: FontWeight.bold)),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('SAP ID',
                      style: TextStyle(
                          fontSize: fontSmall,
                          color: blue,
                          fontWeight: FontWeight.bold)),
                  Text('Seat No.',
                      style: TextStyle(
                          fontSize: fontSmall,
                          color: blue,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(studentDetails['sap_id'] as String,
                      style: const TextStyle(fontSize: fontMedium)),
                  Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      color: blue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        studentDetails['seat_no'] as String,
                        style: const TextStyle(
                          color: white,
                          fontSize: fontMedium,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Text('Roll No.',
                  style: TextStyle(
                      fontSize: fontSmall,
                      color: blue,
                      fontWeight: FontWeight.bold)),
              Text(studentDetails['roll_no'] as String,
                  style: const TextStyle(
                    fontSize: fontMedium,
                  )),
              const Text('Name',
                  style: TextStyle(
                      fontSize: fontSmall,
                      color: blue,
                      fontWeight: FontWeight.bold)),
              Text(studentDetails['student_name'] as String,
                  style: const TextStyle(
                    fontSize: fontMedium,
                  )),
              const Text('Subject Name',
                  style: TextStyle(
                      fontSize: fontSmall,
                      color: blue,
                      fontWeight: FontWeight.bold)),
              Text(studentDetails['subject'] as String,
                  style: const TextStyle(
                    fontSize: fontMedium,
                  )),
              const Text('Subject Code',
                  style: TextStyle(
                      fontSize: fontSmall,
                      color: blue,
                      fontWeight: FontWeight.bold)),
              Text(studentDetails['subject_code'] as String,
                  style: const TextStyle(
                    fontSize: fontMedium,
                  )),
              const Text('Course',
                  style: TextStyle(
                      fontSize: fontSmall,
                      color: blue,
                      fontWeight: FontWeight.bold)),
              Text(studentDetails['course'] as String,
                  style: const TextStyle(
                    fontSize: fontMedium,
                  )),
              const Text('Examination Type',
                  style: TextStyle(
                      fontSize: fontSmall,
                      color: blue,
                      fontWeight: FontWeight.bold)),
              Text(studentDetails['exam_type'] as String,
                  style: const TextStyle(
                    fontSize: fontMedium,
                  )),
              const Text('Eligible',
                  style: TextStyle(
                      fontSize: fontSmall,
                      color: blue,
                      fontWeight: FontWeight.bold)),
              Text(eligibleText,
                  style: TextStyle(fontSize: fontMedium, color: eligibleColor)),
            ],
          ),
        ),
      );
    },
  );
}
