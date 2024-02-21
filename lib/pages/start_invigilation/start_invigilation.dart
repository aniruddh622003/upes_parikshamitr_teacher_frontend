// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/start_invigilation/invigilation_details.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/assign_invigilator.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StartInvigilation extends StatefulWidget {
  const StartInvigilation({super.key});

  @override
  State<StartInvigilation> createState() => _StartInvigilationState();
}

class _StartInvigilationState extends State<StartInvigilation> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  final controllerUniqueCode = TextEditingController();
  void onQRViewCreated(QRViewController controller) {
    String? uniqueCode;
    controller.scannedDataStream.listen((scanData) async {
      // Make the function async
      controller.pauseCamera();

      // Assign the scanned code to the controllerSAP
      uniqueCode = scanData.code.toString();

      // Prepare the data to send to the API
      Map data = {
        'unique_code': uniqueCode.toString(),
        // Add other data if needed
      };

      // Call the API function
      var response = await assignInvigilator(data);

      // Check if the request was successful

      if (response.statusCode == 201) {
        try {
          Map data = jsonDecode(response.body)['data'];
          List roomData = [
            {
              'room_id': data['room']['_id'],
              'room_no': data['room']['room_no'],
              'block': data['room']['block'],
              'floor': data['room']['floor'],
              'room_invigilator_id': data['room']['room_invigilator_id'],
            }
          ];
          const storage = FlutterSecureStorage();
          await storage.write(key: 'room_data', value: jsonEncode(roomData));
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InvigilationDetails(
                    data: jsonDecode(response.body)['data']),
              ));
        } catch (e) {
          errorDialog(context, '${e.toString()}, ${jsonDecode(response.body)}');
        }
      } else {
        // If that response was not OK, throw an error.
        // throw Exception('Failed to load text key');
        var body = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Unique Code'),
              content: Text('Unique Code: $uniqueCode\nError: $body'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: const Text(
            'Scan QR Code',
            style: TextStyle(
              color: white,
            ),
          ),
          backgroundColor: blue,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: blue,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const Center(
                child: Text(
                  'Scan QR Code in Controller Room to get your invigilation details and proceed.',
                  style: TextStyle(
                    color: white,
                    fontSize: fontSmall,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: onQRViewCreated,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Enter code'),
                        content: TextField(
                          controller: controllerUniqueCode,
                          decoration: const InputDecoration(
                              hintText: "Enter your code here"),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text('Back'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: const Text('Confirm'),
                            onPressed: () async {
                              String? uniqueCode =
                                  controllerUniqueCode.text.toString();

                              // Prepare the data to send to the API
                              Map data = {
                                'unique_code': uniqueCode.toString(),
                                // Add other data if needed
                              };

                              // Call the API function
                              var response = await assignInvigilator(data);

                              // Check if the request was successful

                              if (response.statusCode == 201) {
                                try {
                                  Map data = jsonDecode(response.body)['data'];
                                  List roomData = [
                                    {
                                      'room_id': data['room']['_id'],
                                      'room_no': data['room']['room_no'],
                                      'block': data['room']['block'],
                                      'floor': data['room']['floor'],
                                      'room_invigilator_id': data['room']
                                          ['room_invigilator_id'],
                                    }
                                  ];
                                  const storage = FlutterSecureStorage();
                                  await storage.write(
                                      key: 'room_data',
                                      value: jsonEncode(roomData));
                                  Navigator.pop(context);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            InvigilationDetails(
                                                data: jsonDecode(
                                                    response.body)['data']),
                                      ));
                                } catch (e) {
                                  errorDialog(context,
                                      '${e.toString()}, ${jsonDecode(response.body)}');
                                }
                              } else {
                                // If that response was not OK, throw an error.
                                // throw Exception('Failed to load text key');
                                var body = jsonDecode(response.body);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Unique Code'),
                                      content: Text(
                                          'Unique Code: $uniqueCode\nError: $body'),
                                      actions: [
                                        TextButton(
                                          child: const Text('OK'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Can\'t Scan Code? ',
                      style: TextStyle(fontSize: fontMedium, color: black),
                    ),
                    Text(
                      'Type Code.',
                      style: TextStyle(fontSize: fontMedium, color: orange),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
