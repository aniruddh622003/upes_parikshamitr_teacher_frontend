import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart'
    show serverUrl;
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void bsheetPopup(BuildContext context) async {
  late dynamic response;
  late dynamic response2;
  final qrKey = GlobalKey(debugLabel: 'QR');
  final controllerSAP = TextEditingController();
  void onQRViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      controllerSAP.text = scanData.code.toString();
    });
  }

  Future<Map> fetchData() async {
    response = await http.get(Uri.parse(
        '$serverUrl/teacher/invigilation/seating-plan?room_id=65ba84665bfb4b58d77d0184'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> issueBSheet(Map data) async {
    const storage = FlutterSecureStorage();
    final String? jwt = await storage.read(key: 'jwt');
    print('here');
    response2 = await http.patch(
      Uri.parse('$serverUrl/teacher/invigilation/issue-b-sheet'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $jwt',
      },
      body: jsonEncode(data),
    );
    // if (response.statusCode == 200) {
    //   print('Request successful');
    // } else {
    //   print('Failed to send request');
    // }
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
              shrinkWrap: true,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Issue B-Sheet',
                        style: TextStyle(
                            fontSize: fontMedium, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Align the QR code within the frame to scan'),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    height: 300,
                    width: 300,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: onQRViewCreated,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Center(
                    child: Text('OR',
                        style: TextStyle(
                            fontSize: fontMedium,
                            fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                const Center(child: Text('Enter Student’s SAP ID Below')),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: blueXLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: controllerSAP,
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
                      Map data = await fetchData();
                      int indexData = data['data']['seating_plan'].indexWhere(
                          (student) =>
                              student['sap_id'] ==
                              int.parse(controllerSAP.text));
                      if (indexData != -1) {
                        String seatNo =
                            data['data']['seating_plan'][indexData]['seat_no'];

                        Map<String, dynamic> dataStu = {
                          'room_id': '65ba84665bfb4b58d77d0184',
                          'seat_no': seatNo.toString(),
                          'count': 1,
                        };

                        await issueBSheet(dataStu);

                        Navigator.of(context).pop();
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => AttendancePage(
                        //         studentDetails: studentDetails)));
                      } else {
                        errorDialog(context, 'Student not found!');
                      }
                      // consider case for debarred by checkng the studentDetails['eligible'] value
                    },
                    child: const Text('Issue B-Sheet',
                        style: TextStyle(fontSize: fontSmall)),
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
