// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/approve_invigilator.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/invigilator_dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'dart:convert';

void confirmInvigilationCard(
    BuildContext context, List supplies, String roomId) {
  final List<TextEditingController> controllers = List.generate(
    supplies.length,
    (index) => TextEditingController(),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Confirm Invigilation',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        color: blue,
                        fontSize: fontLarge,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please ensure that you have the following:',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      color: black,
                      fontSize: fontMedium,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: supplies.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: blue300,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(supplies[index]['type'],
                                          textScaler:
                                              const TextScaler.linear(1),
                                          style: const TextStyle(
                                              color: white,
                                              fontSize: fontMedium)),
                                    ),
                                    Text("${supplies[index]['quantity']} Nos.",
                                        textScaler: const TextScaler.linear(1),
                                        style: const TextStyle(
                                            color: white,
                                            fontSize: fontMedium)),
                                  ],
                                ),
                                const Text("Received:",
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                        color: white, fontSize: fontSmall)),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: blue50,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    controller: controllers[index],
                                    textAlign: TextAlign.center,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Type here',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        int i = 0;
                        List<Map> pendingSupplies = [];
                        for (i = 0; i < controllers.length; i++) {
                          if (controllers[i].text.isEmpty) {
                            throw Exception(
                                'Invalid value for ${supplies[i]['type']}. Field cannot be empty.');
                          } else if (int.parse(controllers[i].text) < 0) {
                            throw Exception(
                                'Invalid value for ${supplies[i]['type']}. Value must be a non-negative integer.');
                          } else if (int.parse(controllers[i].text) >
                              supplies[i]['quantity']) {
                            throw Exception(
                                'Invalid value for ${supplies[i]['type']}. Value must be smaller than the total amount allocated.');
                          } else {
                            pendingSupplies.add({
                              "type": supplies[i]['type'],
                              "quantity": supplies[i]['quantity'] -
                                  int.parse(controllers[i].text)
                            });
                          }
                        }
                        // savePenddingSupplies(requiredSupplies: pendingSupplies);
                        Map<String, dynamic> dataApproveInvigilator = {
                          "roomId": roomId,
                          "pending_supplies": pendingSupplies,
                        };
                        dynamic responseApproveInvigilator =
                            await approveInvigilator(dataApproveInvigilator);
                        if (responseApproveInvigilator.statusCode == 201 ||
                            responseApproveInvigilator.statusCode == 304) {
                          if (responseApproveInvigilator.statusCode == 304) {
                            Fluttertoast.showToast(
                                msg: "Resumed Invigilation",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 3,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                          // await const FlutterSecureStorage().write(
                          //     key: 'pendingSupplies',
                          //     value: jsonEncode(pendingSupplies));

                          Navigator.of(context).pop();
                          Navigator.of(context).pop();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const InvigilatorDashboard()),
                          );
                        } else {
                          errorDialog(context,
                              jsonDecode(responseApproveInvigilator.body));
                        }
                      } catch (e) {
                        errorDialog(context, e.toString());
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(orange),
                    ),
                    child: const Text(
                      'Confirm and Start Invigilation',
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(color: white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  ).then((_) {
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].dispose();
    }
  });
}
