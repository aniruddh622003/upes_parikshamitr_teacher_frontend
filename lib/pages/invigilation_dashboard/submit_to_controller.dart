// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/submission_to_controller.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/submission_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    String? uniqueCode;
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      uniqueCode = scanData.code.toString();
      String? uniqueCodeLocal =
          await const FlutterSecureStorage().read(key: "unique_code");
      if (uniqueCodeLocal != uniqueCode) {
        errorDialog(context, "Invalid Code");
        return;
      }
      Map data = {
        "unique_code": uniqueCode.toString(),
      };

      var response = await submissionToController(data);

      if (response.statusCode == 201) {
        try {
          await const FlutterSecureStorage()
              .write(key: "submission_state", value: "submitting");
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
              '${e.toString()}, ${jsonDecode(response.body)['message']}');
        }
      } else if (response.statusCode == 202) {
        try {
          Fluttertoast.showToast(
              msg: "Submission Approved!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.grey,
              textColor: Colors.white,
              fontSize: 16.0);
          await const FlutterSecureStorage().delete(key: 'submission_state');
          await const FlutterSecureStorage().delete(key: "unique_code");
          await const FlutterSecureStorage().delete(key: "roomId");
          String? jwt = await const FlutterSecureStorage().read(key: 'jwt');
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(jwt: jwt),
            ),
          );
        } catch (e) {
          errorDialog(context, e.toString());
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
                'Unique Code',
                textScaler: TextScaler.linear(1),
              ),
              content: Text(
                'Unique Code: $uniqueCode\nError: $body',
                textScaler: const TextScaler.linear(1),
              ),
              actions: [
                TextButton(
                  child: const Text(
                    'OK',
                    textScaler: TextScaler.linear(1),
                  ),
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
      //       title: const Text('Scan Successful',textScaler: const TextScaler.linear(1),),
      //       content: Text(scanData.code.toString(),textScaler: const TextScaler.linear(1),),
      //       actions: [
      //         TextButton(
      //           child: const Text('Scan Again',textScaler: const TextScaler.linear(1),),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //             controller.resumeCamera();
      //           },
      //         ),
      //         TextButton(
      //           child: const Text('Continue',textScaler: const TextScaler.linear(1),),
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
            'Scan QR Code',
            textScaler: TextScaler.linear(1),
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
                  'Scan QR Code to complete the examinaton submission.',
                  textScaler: TextScaler.linear(1),
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
                child: kIsWeb
                    ? const Center(
                        child: Text(
                          'QR Code Scanner is currently not supported on Web. Please type the code to proceed.',
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(
                            color: white,
                            fontSize: fontLarge,
                          ),
                        ),
                      )
                    : ClipRRect(
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
                  if (!kIsWeb) {
                    controller?.dispose();
                  }
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          'Enter code',
                          textScaler: TextScaler.linear(1),
                        ),
                        content: TextField(
                          controller: submissionUniqueCode,
                          decoration: const InputDecoration(
                              hintText: "Enter your code here"),
                        ),
                        actions: <Widget>[
                          ElevatedButton(
                            child: const Text(
                              'Back',
                              textScaler: TextScaler.linear(1),
                            ),
                            onPressed: () {
                              controller?.resumeCamera();
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            child: const Text(
                              'Confirm',
                              textScaler: TextScaler.linear(1),
                            ),
                            onPressed: () async {
                              String uniqueCode = submissionUniqueCode.text;
                              String? uniqueCodeLocal =
                                  await const FlutterSecureStorage()
                                      .read(key: "unique_code");
                              if (uniqueCodeLocal != uniqueCode) {
                                errorDialog(context, "Invalid Code");
                                return;
                              }
                              Map data = {
                                "unique_code": uniqueCode.toString(),
                              };

                              var response = await submissionToController(data);

                              if (response.statusCode == 201) {
                                try {
                                  await const FlutterSecureStorage()
                                      .delete(key: "unique_code");
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
                                      builder: (context) =>
                                          const SubmissionDetails(),
                                    ),
                                  );
                                } catch (e) {
                                  errorDialog(context,
                                      '${e.toString()}, ${jsonDecode(response.body)['message']}');
                                }
                              } else if (response.statusCode == 202) {
                                try {
                                  Fluttertoast.showToast(
                                      msg: "Submission Approved!",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 3,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                  const FlutterSecureStorage()
                                      .delete(key: 'submission_state');
                                  const FlutterSecureStorage()
                                      .delete(key: 'invigilation_state');
                                  String? jwt =
                                      await const FlutterSecureStorage()
                                          .read(key: 'jwt');
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Dashboard(jwt: jwt),
                                    ),
                                  );
                                } catch (e) {
                                  errorDialog(context, e.toString());
                                }
                              } else {
                                var body = jsonDecode(response.body);
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        'Unique Code',
                                        textScaler: TextScaler.linear(1),
                                      ),
                                      content: Text(
                                        'Unique Code: $uniqueCode\nError: $body',
                                        textScaler: const TextScaler.linear(1),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text(
                                            'OK',
                                            textScaler: TextScaler.linear(1),
                                          ),
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
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(fontSize: fontMedium, color: black),
                    ),
                    Text(
                      'Type Code.',
                      textScaler: TextScaler.linear(1),
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
