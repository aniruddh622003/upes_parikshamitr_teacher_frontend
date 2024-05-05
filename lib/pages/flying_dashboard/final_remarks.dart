// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/finish_duty.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

void finalRemarks(BuildContext context) {
  TextEditingController controllerRemarks = TextEditingController();
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
              // mainAxisSize: MainAxisSize.min,
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
              shrinkWrap: true,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Final Remarks',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(
                            fontSize: fontMedium, fontWeight: FontWeight.bold)),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: blueXLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: controllerRemarks,
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Type here',
                    ),
                  ),
                ),
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
                        Loader.show(context,
                            isAppbarOverlay: true,
                            isBottomBarOverlay: true,
                            progressIndicator:
                                const CircularProgressIndicator());
                        dynamic response =
                            await finishDuty(controllerRemarks.text);
                        if (response.statusCode == 201) {
                          const storage = FlutterSecureStorage();

                          // Read and store 'jwt' and 'notifications'
                          String? jwt = await storage.read(key: 'jwt');
                          String? notifications =
                              await storage.read(key: 'notifications');

                          // Delete all data
                          await storage.deleteAll();

                          // Write back 'jwt' and 'notifications' if they were not null
                          if (jwt != null) {
                            await storage.write(key: 'jwt', value: jwt);
                          }
                          if (notifications != null) {
                            await storage.write(
                                key: 'notifications', value: notifications);
                          }
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Dashboard(jwt: jwt)),
                          );
                          Loader.hide();
                        } else {
                          Loader.hide();
                          errorDialog(context,
                              "An error occurred while submitting remarks. Please try again.");
                        }
                      } catch (e) {
                        errorDialog(context, e.toString());
                      } finally {
                        Loader.hide();
                      }
                    },
                    child: const Text('Submit Remarks',
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
