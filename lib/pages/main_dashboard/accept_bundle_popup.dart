// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/accept_bundle.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void acceptBundlePopup(BuildContext context, Map sheetData) {
  List<String> bundleList = [];
  Map bundleData = {};
  for (var copy in sheetData['copies']) {
    if (copy['status'] == 'ALLOTTED') {
      bundleList.add(copy['program'] + " " + copy['batch']);
      bundleData[copy['program'] + " " + copy['batch']] = copy;
    }
  }
  String dropdownValue = bundleList[0];
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
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
                        const Text('Select Bundle',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                                fontSize: fontMedium,
                                fontWeight: FontWeight.bold)),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue.toString();
                          });
                        },
                        items: bundleList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
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
                            Map data = {
                              "bundle_id": sheetData['_id'],
                              "batch": bundleData[dropdownValue]['batch'],
                              "program": bundleData[dropdownValue]['program'],
                            };
                            dynamic response = await acceptBundle(data);
                            if (response.statusCode == 200) {
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg:
                                      "Bundle Accepted. Please wait 10 seconds for the page to refresh.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.green,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              errorDialog(context, response.body);
                            }
                          } catch (e) {
                            errorDialog(context, e.toString());
                          }
                        },
                        child: const Text('Confirm',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(fontSize: fontSmall)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }, // Add this
      );
    },
  );
}
