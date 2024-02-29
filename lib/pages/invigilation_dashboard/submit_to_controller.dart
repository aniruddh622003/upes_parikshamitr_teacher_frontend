import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/submission_to_controller.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/submission_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class SubmitToController extends StatefulWidget {
  const SubmitToController({super.key});

  @override
  State<SubmitToController> createState() => _SubmitToControllerState();
}

class _SubmitToControllerState extends State<SubmitToController> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  final submissionUniqueCode = TextEditingController();
  QRViewController? controller;

  void onQRViewCreated(QRViewController controller) {
    String? uniqueCode;
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      uniqueCode = scanData.code.toString();
      Map data = {
        "unique_code": uniqueCode.toString(),
      };

      var response = await submissionToController(data);

      if (response.statusCode == 201) {
        try {
          // pendingReq(context);
          await const FlutterSecureStorage()
              .write(key: "submission_state", value: "submitting");
          await const FlutterSecureStorage().delete(key: "invigilation_state");
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SubmissionDetails(),
            ),
          );
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
              title: const Text(
                  textScaler: TextScaler.linear(1), 'Unique Code'),
              content: Text(
                  textScaler: const TextScaler.linear(1),
                  'Unique Code: $uniqueCode\nError: $body'),
              actions: [
                TextButton(
                  child:
                      const Text(textScaler: TextScaler.linear(1), 'OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: const Text(textScaler: const TextScaler.linear(1),'Scan Successful'),
      //       content: Text(textScaler: const TextScaler.linear(1),scanData.code.toString()),
      //       actions: [
      //         TextButton(
      //           child: const Text(textScaler: const TextScaler.linear(1),'Scan Again'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //             controller.resumeCamera();
      //           },
      //         ),
      //         TextButton(
      //           child: const Text(textScaler: const TextScaler.linear(1),'Continue'),
      //           onPressed: () {
      //             controller.dispose();
      //             Navigator.of(context).pop();
      //             pendingReq(context);
      //           },
      //         ),
      //       ],
      //     );
      //   },
      // );
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
            textScaler: TextScaler.linear(1),
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
                  textScaler: TextScaler.linear(1),
                  'Scan QR Code to complete the examinaton submission.',
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
                  controller?.pauseCamera();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                            textScaler: TextScaler.linear(1),
                            'Enter code'),
                        content: TextField(
                          controller: submissionUniqueCode,
                          decoration: const InputDecoration(
                              hintText: "Enter your code here"),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text(
                                textScaler: TextScaler.linear(1), 'Back'),
                            onPressed: () {
                              controller?.resumeCamera();
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: const Text(
                                textScaler: TextScaler.linear(1),
                                'Confirm'),
                            onPressed: () async {
                              String uniqueCode = submissionUniqueCode.text;
                              Map data = {
                                "unique_code": uniqueCode.toString(),
                              };

                              var response = await submissionToController(data);

                              if (response.statusCode == 201) {
                                try {
                                  // pendingReq(context);
                                  await const FlutterSecureStorage().write(
                                      key: "submission_state",
                                      value: "submitting");
                                  await const FlutterSecureStorage()
                                      .delete(key: "invigilation_state");
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const SubmissionDetails(),
                                    ),
                                  );
                                } catch (e) {
                                  errorDialog(context,
                                      '${e.toString()}, ${jsonDecode(response.body)}');
                                }
                              } else {
                                var body = jsonDecode(response.body);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          textScaler:
                                              TextScaler.linear(1),
                                          'Unique Code'),
                                      content: Text(
                                          textScaler:
                                              const TextScaler.linear(1),
                                          'Unique Code: $uniqueCode\nError: $body'),
                                      actions: [
                                        TextButton(
                                          child: const Text(
                                              textScaler:
                                                  TextScaler.linear(1),
                                              'OK'),
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
                      textScaler: TextScaler.linear(1),
                      'Can\'t Scan Code? ',
                      style: TextStyle(fontSize: fontMedium, color: black),
                    ),
                    Text(
                      textScaler: TextScaler.linear(1),
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
