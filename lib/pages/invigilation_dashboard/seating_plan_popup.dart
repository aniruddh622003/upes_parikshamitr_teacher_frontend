import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void seatingPlanPopup(
    BuildContext context, Map<String, dynamic> studentDetails) {
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
  } else if (studentDetails['eligible'] == 'R_HOLD') {
    eligibleColor = magenta;
    eligibleText = "NO (REGISTRATION HOLD)";
  } else {
    eligibleColor = grayDark;
    eligibleText = "NO";
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
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
                    const Text(
                        textScaler: TextScaler.linear(1),
                        'Student Details',
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
                    Text(
                        textScaler: TextScaler.linear(1),
                        'SAP ID',
                        style: TextStyle(
                            fontSize: fontSmall,
                            color: blue,
                            fontWeight: FontWeight.bold)),
                    Text(
                        textScaler: TextScaler.linear(1),
                        'Seat No.',
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
                    Text(
                        textScaler: const TextScaler.linear(1),
                        studentDetails['sap_id'].toString(),
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
                          textScaler: const TextScaler.linear(1),
                          studentDetails['seat_no'].toString(),
                          style: const TextStyle(
                            color: white,
                            fontSize: fontMedium,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Text(
                    textScaler: TextScaler.linear(1),
                    'Roll No.',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(
                    textScaler: const TextScaler.linear(1),
                    studentDetails['roll_no'].toString(),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text(
                    textScaler: TextScaler.linear(1),
                    'Name',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(
                    textScaler: const TextScaler.linear(1),
                    studentDetails['student_name'].toString(),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text(
                    textScaler: TextScaler.linear(1),
                    'Subject Name',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(
                    textScaler: const TextScaler.linear(1),
                    studentDetails['subject'].toString(),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text(
                    textScaler: TextScaler.linear(1),
                    'Subject Code',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(
                    textScaler: const TextScaler.linear(1),
                    studentDetails['subject_code'].toString(),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text(
                    textScaler: TextScaler.linear(1),
                    'Course',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(
                    textScaler: const TextScaler.linear(1),
                    studentDetails['course'].toString(),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text(
                    textScaler: TextScaler.linear(1),
                    'Examination Type',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(
                    textScaler: const TextScaler.linear(1),
                    studentDetails['exam_type'].toString(),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text(
                    textScaler: TextScaler.linear(1),
                    'A Sheet Number',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(
                    textScaler: const TextScaler.linear(1),
                    studentDetails['ans_sheet_number'].toString() == 'null'
                        ? 'Not Allotted'
                        : studentDetails['ans_sheet_number'].toString(),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text(
                    textScaler: TextScaler.linear(1),
                    'B Sheet Count',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(
                    textScaler: const TextScaler.linear(1),
                    studentDetails['b_sheet_count'].toString(),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text(
                    textScaler: TextScaler.linear(1),
                    'Eligible',
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(
                    textScaler: const TextScaler.linear(1),
                    eligibleText,
                    style:
                        TextStyle(fontSize: fontMedium, color: eligibleColor)),
              ],
            ),
          ),
        ),
      );
    },
  );
}
