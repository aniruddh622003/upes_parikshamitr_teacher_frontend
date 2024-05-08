// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/student_attendance_search.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';

class StudentAttendanceSearch extends StatefulWidget {
  const StudentAttendanceSearch({super.key});

  @override
  State<StudentAttendanceSearch> createState() =>
      _StudentAttendanceSearchState();
}

class _StudentAttendanceSearchState extends State<StudentAttendanceSearch> {
  TextEditingController sapIdController = TextEditingController();
  Map data = {};

  List<Widget> makeCards(Map data) {
    List<Widget> cards = [];
    if (data.isEmpty) {
      return cards;
    }
    for (Map roomData in data['rooms']) {
      cards.add(Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: blue50,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date: ${roomData['date']}',
                      textScaler: const TextScaler.linear(1),
                      style: const TextStyle(
                          fontSize: fontMedium, fontWeight: FontWeight.bold),
                    ),
                    Text('Time Slot: ${roomData['timeSlot']}',
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(fontSize: fontSmall)),
                    Text('Room No: ${roomData['room_no']}',
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(fontSize: fontSmall)),
                    Text('Subject Code: ${roomData['subject_code']}',
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(fontSize: fontSmall)),
                  ],
                ),
              ),
              Container(
                width: 40, // Circle size
                height: 40, // Circle size
                decoration: BoxDecoration(
                  color: roomData['attendance'] ? Colors.green : Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    roomData['attendance'] ? 'P' : 'A',
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20), // Adjust font size as needed
                  ),
                ),
              ),
            ],
          ),
        ),
      ));
      cards.add(const SizedBox(height: 10));
    }
    return cards;
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
        title: const Text(
          'Check Attendance',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: white, fontSize: fontMedium),
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: white,
              ),
              child: ListView(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: sapIdController,
                              keyboardType:
                                  TextInputType.number, // Only accept digits
                              decoration: InputDecoration(
                                hintText: "Enter SAP ID",
                                filled: true,
                                fillColor: white,
                                contentPadding: const EdgeInsets.all(10),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(color: blue),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const BorderSide(color: blue),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                              width:
                                  10), // Spacing between the text field and the button
                          ElevatedButton(
                            onPressed: () async {
                              if (sapIdController.text.isEmpty) {
                                errorDialog(context, "Please enter SAP ID!");
                              } else {
                                try {
                                  dynamic response = await studentSearch(
                                    int.parse(sapIdController.text),
                                  );
                                  if (response.statusCode == 200) {
                                    setState(() {
                                      data = jsonDecode(response.body)['data'];
                                    });
                                  } else {
                                    errorDialog(context, "Student not found!");
                                  }
                                } catch (e) {
                                  errorDialog(context, e.toString());
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: blue, // Background color
                              foregroundColor: white, // Text color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: const Text('Search'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      if (data.isNotEmpty) ...[
                        const Text('Attendance Details',
                            style: TextStyle(
                                fontSize: fontMedium,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        const Text('SAP ID',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                                fontSize: fontMedium,
                                color: blue,
                                fontWeight: FontWeight.bold)),
                        Text("${data['sap_id']}",
                            textScaler: const TextScaler.linear(1),
                            style: const TextStyle(
                              fontSize: fontMedium,
                            )),
                        const Text('Roll Number',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                                fontSize: fontMedium,
                                color: blue,
                                fontWeight: FontWeight.bold)),
                        Text("${data['roll_no']}",
                            textScaler: const TextScaler.linear(1),
                            style: const TextStyle(
                              fontSize: fontMedium,
                            )),
                        const Text('Name',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                                fontSize: fontMedium,
                                color: blue,
                                fontWeight: FontWeight.bold)),
                        Text("${data['name']}",
                            textScaler: const TextScaler.linear(1),
                            style: const TextStyle(
                              fontSize: fontMedium,
                            )),
                        const SizedBox(height: 10),
                        ...makeCards(data),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
