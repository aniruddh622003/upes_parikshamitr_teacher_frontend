import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/submission_to_controller.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/pending_req.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class SubmitToController extends StatefulWidget {
  const SubmitToController({super.key});

  @override
  State<SubmitToController> createState() => _SubmitToControllerState();
}

class _SubmitToControllerState extends State<SubmitToController> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  final submissionUniqueCode = TextEditingController();
  

  void onQRViewCreated(QRViewController controller) {
    String? uniqueCode;
    controller.scannedDataStream.listen((scanData) async{
      controller.pauseCamera();
      uniqueCode = scanData.code.toString();
      Map data ={
        "uniqueCode": uniqueCode.toString(),
      };

      var response = await submissionToController(data);

      if(response.statusCode == 201){
        try{
          errorDialog(context, jsonDecode(response.body).toString());
          pendingReq(context);

        }catch (e) {
          errorDialog(context, '${e.toString()}, ${jsonDecode(response.body)}');
        }

      }
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: const Text('Scan Successful'),
      //       content: Text(scanData.code.toString()),
      //       actions: [
      //         TextButton(
      //           child: const Text('Scan Again'),
      //           onPressed: () {
      //             Navigator.of(context).pop();
      //             controller.resumeCamera();
      //           },
      //         ),
      //         TextButton(
      //           child: const Text('Continue'),
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
                          onChanged: (value) {
                            // Store your value here
                          },
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
                            onPressed: () {
                              Navigator.of(context).pop();
                              pendingReq(context);
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
