// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/approve_flying_visit.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

Future<void> flyingVisitPopup(BuildContext context, Map flying) {
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
                    const Text('Update Flying Status',
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
                const Text('Name',
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                        fontSize: fontSmall,
                        color: blue,
                        fontWeight: FontWeight.bold)),
                Text(flying['teacher']['name'].toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontMedium,
                    )),
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
                      try {
                        String? roomId = await const FlutterSecureStorage()
                            .read(key: 'roomId');
                        Map data = {
                          "room_id": roomId,
                          "flying_squad_id": flying['_id'],
                        };
                        dynamic response = await approveFlyingVisit(data);
                        if (response.statusCode == 201) {
                          Fluttertoast.showToast(
                              msg: "Flying Squad visit approved.",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: white,
                              textColor: black,
                              fontSize: 16.0);
                          Navigator.pop(context);
                        } else {
                          errorDialog(context,
                              "An error occurred while approving flying squad visit.");
                        }
                      } catch (e) {
                        errorDialog(context, e.toString());
                      }
                    },
                    child: const Text('Approve Visit',
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
  return Future.value();
}
