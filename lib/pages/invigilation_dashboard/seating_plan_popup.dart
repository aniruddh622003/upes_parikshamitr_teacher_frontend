// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_debarred_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/ufm_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void seatingPlanPopup(
    BuildContext context, Map<String, dynamic> studentDetails) async {
  Color eligibleColor;
  String eligibleText = "";
  bool isFlying =
      await const FlutterSecureStorage().read(key: 'slotId') != null;

  String btnText = "";
  if (isFlying) {
    btnText = "Give UFM";
  } else {
    btnText = "Mark Attendance";
  }

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
    eligibleColor = orange;
    eligibleText = "NO (REGISTRATION HOLD)";
  } else if (studentDetails['eligible'] == 'UFM') {
    eligibleColor = magenta;
    eligibleText = "UFM Case";
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
            child: ListView(
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              shrinkWrap: true,
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
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                        fontFamily: 'fontMedium',
                        fontSize: fontMedium), // Use the predefined font size
                    children: [
                      if (studentDetails['ans_sheet_number'].toString() ==
                          'null')
                        const TextSpan(text: 'Not Allotted')
                      else if (studentDetails['UFM'] != null)
                        if (studentDetails['new_ans_sheet_number'] == null)
                          const TextSpan(text: 'Cancelled')
                        else
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    '${studentDetails['ans_sheet_number'].toString()} ',
                                style: const TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize:
                                        fontMedium), // Use the predefined font size
                              ),
                              const WidgetSpan(
                                child: SizedBox(
                                    width:
                                        5), // Add a gap between the two sheet numbers
                              ),
                              TextSpan(
                                text: studentDetails['new_ans_sheet_number']
                                    .toString(),
                                style: const TextStyle(
                                    fontSize:
                                        fontMedium), // Use the predefined font size
                              ),
                            ],
                          )
                      else
                        TextSpan(
                            text: studentDetails['ans_sheet_number'].toString(),
                            style: const TextStyle(
                                fontSize:
                                    fontMedium)), // Use the predefined font size
                    ],
                  ),
                ), // Apply the TextScaler
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
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                      foregroundColor: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isFlying && studentDetails['attendance']
                        ? () async {
                            try {
                              if (studentDetails['eligible'] == 'YES' ||
                                  studentDetails['eligible'] == 'UFM') {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UFMPage(
                                        studentDetails: studentDetails)));
                              } else if (studentDetails['eligible'] ==
                                      'F_HOLD' ||
                                  studentDetails['eligible'] == 'DEBARRED' ||
                                  studentDetails['eligible'] == 'R_HOLD') {
                                errorDialog(context, "Student is not eligible");
                              }
                            } catch (e) {
                              errorDialog(context, e.toString());
                            }
                          }
                        : studentDetails['attendance'] ||
                                !(studentDetails['eligible'] == 'YES')
                            ? null
                            : !isFlying
                                ? () async {
                                    try {
                                      if (studentDetails['eligible'] == 'YES') {
                                        Navigator.of(context).pop();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AttendancePage(
                                                        studentDetails:
                                                            studentDetails)));
                                      } else if (studentDetails['eligible'] ==
                                              'F_HOLD' ||
                                          studentDetails['eligible'] ==
                                              'DEBARRED' ||
                                          studentDetails['eligible'] ==
                                              'R_HOLD') {
                                        attendanceErrorDialog(context);
                                      }
                                    } catch (e) {
                                      errorDialog(context, e.toString());
                                    }
                                  }
                                : null,
                    child: Text(btnText,
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(fontSize: fontSmall)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
