// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_debarred_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/custom_barcode_scanner.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/ufm_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_room_details.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'dart:convert';

void ufmPopup(BuildContext context) {
  TextEditingController controllerSAP = TextEditingController();

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
              shrinkWrap: true,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Issue UFM',
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
                const Text(
                  'Open the Barcode scanner and align in the frame to scan',
                  textScaler: TextScaler.linear(1),
                ),
                const SizedBox(height: 10),
                kIsWeb
                    ? const Center(
                        child: Text(
                            "Barcode Scanner is currently not supported on Web. Please type the code to proceed."))
                    : Center(
                        child: Container(
                          height: 300,
                          width: 300,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/home_art.png'),
                            fit: BoxFit.contain,
                          )),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: GestureDetector(
                                child: CustomBarcodeScanner(
                                  onBarcodeScanned: (displayValue) {
                                    controllerSAP.text = displayValue;
                                  },
                                ),
                              )),
                        ),
                      ),
                const SizedBox(height: 10),
                const Center(
                    child: Text('OR',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                            fontSize: fontMedium,
                            fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                const Center(
                    child: Text(
                  'Enter Student’s SAP ID Below',
                  textScaler: TextScaler.linear(1),
                )),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: blueXLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: controllerSAP,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
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
                      backgroundColor: orange,
                      foregroundColor: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        if (controllerSAP.text.isEmpty) {
                          errorDialog(context, 'Please enter SAP ID!');
                          return;
                        }
                        const storage = FlutterSecureStorage();
                        final String? roomId =
                            await storage.read(key: 'roomId');
                        dynamic data = await getRoomDetails(roomId.toString());
                        if (data != null) {
                          if (data.statusCode == 200) {
                            Map roomDetails = jsonDecode(data.body);
                            int indexData = roomDetails['data']['seating_plan']
                                .indexWhere((student) =>
                                    student['sap_id'] ==
                                    int.parse(controllerSAP.text));
                            if (indexData != -1) {
                              if (roomDetails['data']['seating_plan'][indexData]
                                      ['attendance'] ||
                                  roomDetails['data']['seating_plan'][indexData]
                                          ['eligible'] ==
                                      'UFM') {
                                Map<dynamic, dynamic> studentDetails =
                                    roomDetails['data']['seating_plan']
                                        [indexData];
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UFMPage(
                                        studentDetails: studentDetails)));
                              } else if (roomDetails['data']['seating_plan']
                                          [indexData]['eligible'] ==
                                      'F_HOLD' ||
                                  roomDetails['data']['seating_plan'][indexData]
                                          ['eligible'] ==
                                      'DEBARRED') {
                                Navigator.of(context).pop();
                                attendanceErrorDialog(context);
                              } else if (!roomDetails['data']['seating_plan']
                                  [indexData]['attendance']) {
                                Navigator.pop(context);
                                errorDialog(
                                    context, 'Student not marked present!');
                              }
                            } else {
                              Navigator.pop(context);
                              errorDialog(context, 'Student not found!');
                            }
                          } else {
                            Navigator.pop(context);
                            errorDialog(context,
                                "An error while fetching seating plan!");
                          }
                        } else {
                          Navigator.pop(context);
                          errorDialog(
                              context, "An error while fetching seating plan!");
                        }
                      } catch (e) {
                        Navigator.pop(context);
                        errorDialog(context, e.toString());
                      }
                    },
                    child: const Text('Report Candidate',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(fontSize: fontSmall)),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  ).then((_) {
    // controllerSAP.dispose();
  });
}
