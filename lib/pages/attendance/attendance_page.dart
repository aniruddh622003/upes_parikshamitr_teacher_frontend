// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/mark_attendance.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';

class AttendancePage extends StatefulWidget {
  final Map<dynamic, dynamic> studentDetails;

  const AttendancePage({super.key, required this.studentDetails});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final controllerSheetNo = TextEditingController();

  @override
  void dispose() {
    // controllerSheetNo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Seating Arrangement',
              textScaler: TextScaler.linear(1),
              style: TextStyle(color: white),
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: white),
          onPressed: () {
            try {
              Navigator.pop(context);
            } catch (e) {
              errorDialog(context, e.toString());
            }
          },
        ),
      ),
      body: Column(
        children: [
          const Center(
            child: Text("Attendance",
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  color: white,
                  fontSize: fontXLarge,
                )),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Student Details',
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                    fontSize: fontMedium,
                                    fontWeight: FontWeight.bold)),
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
                            Text(widget.studentDetails['sap_id'].toString(),
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
                                  widget.studentDetails['seat_no'].toString(),
                                  textScaler: const TextScaler.linear(1),
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
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                                fontSize: fontSmall,
                                color: blue,
                                fontWeight: FontWeight.bold)),
                        Text(widget.studentDetails['roll_no'].toString(),
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
                        Text(widget.studentDetails['student_name'].toString(),
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
                        Text(widget.studentDetails['subject'].toString(),
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
                        Text(widget.studentDetails['subject_code'].toString(),
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
                        Text(widget.studentDetails['course'].toString(),
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
                        Text(widget.studentDetails['exam_type'].toString(),
                            textScaler: const TextScaler.linear(1),
                            style: const TextStyle(
                              fontSize: fontMedium,
                            )),
                        // const SizedBox(height: 20),
                        const Text('Answer Sheet Number',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                                fontSize: fontSmall,
                                color: blue,
                                fontWeight: FontWeight.bold)),
                        const Center(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: blueXLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: controllerSheetNo,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only digits allowed.
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type Sheet Number',
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 45,
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue,
                              foregroundColor: white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () async {
                              try {
                                if (controllerSheetNo.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please enter answer sheet number",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: white,
                                      textColor: black,
                                      fontSize: 16.0);
                                } else {
                                  final String? roomId =
                                      await const FlutterSecureStorage()
                                          .read(key: 'roomId');
                                  Map data = {
                                    'room_id': roomId,
                                    'sap_id': widget.studentDetails['sap_id'],
                                    'ans_sheet_number':
                                        int.parse(controllerSheetNo.text),
                                  };
                                  dynamic response = await markAttendance(data);
                                  if (response.statusCode >= 200 &&
                                      response.statusCode < 210) {
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                      msg:
                                          "Updating Attendance, please wait for around 10 seconds!",
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 3,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: white,
                                      textColor: black,
                                      fontSize: 16.0,
                                    );
                                  } else {
                                    String msg =
                                        jsonDecode(response.body)['message']
                                            .toString();
                                    Fluttertoast.showToast(
                                      msg: msg,
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 3,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: white,
                                      textColor: black,
                                      fontSize: 16.0,
                                    );
                                  }
                                  FocusScope.of(context).unfocus();
                                }
                              } catch (e) {
                                errorDialog(context, e.toString());
                              }
                            },
                            child: const Text('Mark Attendance',
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(fontSize: fontSmall)),
                          ),
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
