// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/approve_invigilator.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/invigilator_dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
                    style: TextStyle(
                        color: blue,
                        fontSize: fontLarge,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please ensure that you have the following:',
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
                                          style: const TextStyle(
                                              color: white,
                                              fontSize: fontMedium)),
                                    ),
                                    Text("${supplies[index]['quantity']} Nos.",
                                        style: const TextStyle(
                                            color: white,
                                            fontSize: fontMedium)),
                                  ],
                                ),
                                const Text("Received:",
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
                      int i = 0;
                      List<Map> pendingSupplies = [];
                      try {
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
                        if (responseApproveInvigilator.statusCode == 201) {
                          await const FlutterSecureStorage().write(key: 'pendingSupplies', value: jsonEncode(pendingSupplies));
                          Navigator.of(context).pop();
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
  );
}
