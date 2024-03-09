// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/update_supplies.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/invigilator_dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

void pendingSuppliesPopup(BuildContext context,
    Map<dynamic, dynamic> supplyDetails, List<dynamic> pendingSuppliesList) {
  int index = pendingSuppliesList.indexOf(supplyDetails);
  TextEditingController controller = TextEditingController();
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
                    const Text('Pending Supplies Detail',
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
                    Text('Supplies Pending',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                            fontSize: fontSmall,
                            color: blue,
                            fontWeight: FontWeight.bold)),
                    Text('Pending',
                        textScaler: TextScaler.linear(1),
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
                    Flexible(
                      child: Text(supplyDetails['type'] as String,
                          textScaler: const TextScaler.linear(1),
                          style: const TextStyle(fontSize: fontMedium)),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: orange,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          supplyDetails['quantity'].toString(),
                          textScaler: const TextScaler.linear(1),
                          style: const TextStyle(
                            color: white,
                            fontSize: fontMedium,
                          ),
                        ),
                      ),
                    )
                  ],
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
                    controller: controller,
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
                        if (controller.text.isEmpty) {
                          throw 'Please enter the quantity';
                        } else if (int.parse(controller.text) >
                            supplyDetails['quantity']) {
                          throw 'Quantity cannot be more than the pending quantity';
                        } else if (int.parse(controller.text) < 0) {
                          throw 'Quantity cannot be negative';
                        } else {
                          pendingSuppliesList[index]['quantity'] =
                              supplyDetails['quantity'] -
                                  int.parse(controller.text);
                          final String? roomId =
                              await const FlutterSecureStorage()
                                  .read(key: 'roomId');
                          Map data = {
                            "pending_supplies": pendingSuppliesList,
                            "room_id": roomId.toString(),
                          };
                          dynamic response = await updateSupplies(data);
                          if (response.statusCode == 200) {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const InvigilatorDashboard()));
                            Fluttertoast.showToast(
                                msg: "Success",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                textColor: white,
                                backgroundColor: green,
                                timeInSecForIosWeb: 3,
                                fontSize: 16.0);
                          } else {
                            throw 'Failed to update supplies ${jsonDecode(response.body)}';
                          }
                          // Save the updated list to secure storage
                        }
                      } catch (e) {
                        errorDialog(context, e.toString());
                      }
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
  ).then((_) {
    controller.dispose();
  });
}
