// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/add_supplies.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/update_supplies.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/invigilator_dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

void addPendingSuppliesPopup(BuildContext context) {
  // int index = pendingSuppliesList.indexOf(supplyDetails);
  TextEditingController supplyName = TextEditingController();
  TextEditingController supplyNumber = TextEditingController();
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Request Supplies',
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Name of the supply',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                            fontSize: fontSmall,
                            color: blue,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: blueXLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: supplyName,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type here',
                    ),
                  ),
                ),
                const Text('Update newly received quantity:',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: blueXLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    controller: supplyNumber,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type here',
                    ),
                  ),
                ),
                SizedBox(
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
                      try {
                        const storage = FlutterSecureStorage();
                        String? roomId = await storage.read(key: 'roomId');
                        String? jwt = await storage.read(key: 'jwt');
                        Map data = {
                          "room_id": roomId,
                          "pending_supplies": [
                            {
                              "type": supplyName.text,
                              "quantity": int.parse(supplyNumber.text),
                            }
                          ]
                        };
                        dynamic response = await addSupplies(data);
                        if (response.statusCode == 200) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const InvigilatorDashboard()));
                          Fluttertoast.showToast(
                              msg: "Supplies Added Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        } else {
                          print(jsonDecode(response.body)["message"]);
                          errorDialog(
                              context, jsonDecode(response.body)["message"]);
                        }
                      } catch (e) {
                        errorDialog(context, e.toString());
                      }
                      ;
                    },
                    child: const Text('Confirm Update',
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
  );
}
