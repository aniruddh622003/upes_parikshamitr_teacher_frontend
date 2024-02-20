import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart'
    show serverUrl;
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendancePage extends StatelessWidget {
  final Map<dynamic, dynamic> studentDetails;
  final controllerSheetNo = TextEditingController();

  AttendancePage({super.key, required this.studentDetails});

  Future<void> markAttendance(String roomId) async {
    const storage = FlutterSecureStorage();
    final String? jwt = await storage.read(key: 'jwt');

    final _ = await http.post(
      Uri.parse('$serverUrl/teacher/invigilation/mark-attendance'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode(<String, dynamic>{
        'room_id': roomId,
        'sap_id': studentDetails['sap_id'],
        'ans_sheet_number': int.parse(controllerSheetNo.text),
      }),
    );

    // if (response.statusCode == 200) {
    //   // If the server returns a 200 OK response, parse the JSON.
    //   // return response.body;
    //   print(jsonDecode(response.body)['message']);
    // } else {
    //   // If the server did not return a 200 OK response,
    //   // then throw an exception.
    //   print(jsonDecode(response.body)['message']);
    //   // throw Exception('Failed to mark attendance');
    // }
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
              style: TextStyle(color: white),
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const Center(
            child: Text("Room: 11013",
                style: TextStyle(
                  color: white,
                  fontSize: fontXLarge,
                )),
          ),
          const Center(
            child: Text("2:00 - 5:00 PM",
                style: TextStyle(
                  color: white,
                  fontSize: fontSmall,
                )),
          ),
          const Center(
            child: Text("Mr. Vir Das & Mrs. Richa",
                style: TextStyle(
                  color: white,
                  fontSize: fontSmall,
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
                            Text(studentDetails['sap_id'].toString(),
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
                        Text(studentDetails['roll_no'].toString(),
                            style: const TextStyle(
                              fontSize: fontMedium,
                            )),
                        const Text('Name',
                            style: TextStyle(
                                fontSize: fontSmall,
                                color: blue,
                                fontWeight: FontWeight.bold)),
                        Text(studentDetails['student_name'].toString(),
                            style: const TextStyle(
                              fontSize: fontMedium,
                            )),
                        const Text('Subject Name',
                            style: TextStyle(
                                fontSize: fontSmall,
                                color: blue,
                                fontWeight: FontWeight.bold)),
                        Text(studentDetails['subject'].toString(),
                            style: const TextStyle(
                              fontSize: fontMedium,
                            )),
                        const Text('Subject Code',
                            style: TextStyle(
                                fontSize: fontSmall,
                                color: blue,
                                fontWeight: FontWeight.bold)),
                        Text(studentDetails['subject_code'].toString(),
                            style: const TextStyle(
                              fontSize: fontMedium,
                            )),
                        const Text('Course',
                            style: TextStyle(
                                fontSize: fontSmall,
                                color: blue,
                                fontWeight: FontWeight.bold)),
                        Text(studentDetails['course'].toString(),
                            style: const TextStyle(
                              fontSize: fontMedium,
                            )),
                        const Text('Examination Type',
                            style: TextStyle(
                                fontSize: fontSmall,
                                color: blue,
                                fontWeight: FontWeight.bold)),
                        Text(studentDetails['exam_type'].toString(),
                            style: const TextStyle(
                              fontSize: fontMedium,
                            )),
                        const SizedBox(height: 20),
                        const Center(
                          child: Text("Sheet Number",
                              style: TextStyle(
                                color: black,
                                fontSize: fontLarge,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: blueXLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: controllerSheetNo,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Type here',
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
                              const storage = FlutterSecureStorage();
                              dynamic roomData =
                                  await storage.read(key: 'room_data');
                              markAttendance(jsonDecode(roomData.toString())[0]
                                  ['room_id']);
                              Navigator.pop(context);
                              attendancePopup(context);
                            },
                            child: const Text('Mark Attendance',
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
