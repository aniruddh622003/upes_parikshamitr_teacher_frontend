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
                    const Text('Student Details',
                        textScaler: TextScaler.linear(1),
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
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                            fontSize: fontSmall,
                            color: blue,
                            fontWeight: FontWeight.bold)),
                    Text('Seat No.',
                        textScaler: TextScaler.linear(1),
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
                    Text(studentDetails['sap_id'].toString(),
                        textScaler: const TextScaler.linear(1),
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
                          studentDetails['seat_no'].toString(),
                          textScaler: const TextScaler.linear(1),
                          style: const TextStyle(
                            color: white,
                            fontSize: fontMedium - 3,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const Text('Roll No.',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(studentDetails['roll_no'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text('Name',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(studentDetails['student_name'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text('Subject Name',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(studentDetails['subject'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text('Subject Code',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(studentDetails['subject_code'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text('Course',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(studentDetails['course'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text('Examination Type',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(studentDetails['exam_type'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text('A Sheet Number',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(
                    studentDetails['ans_sheet_number'].toString() == 'null'
                        ? 'Not Allotted'
                        : studentDetails['ans_sheet_number'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text('B Sheet Count',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(studentDetails['b_sheet_count'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
                const Text('Eligible',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(eligibleText,
                    textScaler: const TextScaler.linear(1),
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
