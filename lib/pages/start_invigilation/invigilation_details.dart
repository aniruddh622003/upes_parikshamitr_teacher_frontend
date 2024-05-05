// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_supplies.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/invigilator_dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/start_invigilation/invigilation_details_card.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class InvigilationDetails extends StatelessWidget {
  final Map<dynamic, dynamic> data;
  const InvigilationDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: const Text(
            'Details',
            textScaler: TextScaler.linear(1),
            style: TextStyle(
              color: white,
            ),
          ),
          backgroundColor: blue,
          elevation: 0,
        ),
        backgroundColor: blue,
        body: ListView(
          children: [
            const SizedBox(
              height: 20,
            ),
            InvigilationDetailsCard(data: data),
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                onPressed: () async {
                  try {
                    Loader.show(context,
                        isAppbarOverlay: true,
                        isBottomBarOverlay: true,
                        progressIndicator: const CircularProgressIndicator());
                    dynamic response = await getSupplies();
                    Loader.hide();
                    if (response.statusCode == 200) {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const InvigilatorDashboard()),
                      );
                    } else if (response.statusCode == 404) {
                      await const FlutterSecureStorage()
                          .delete(key: "unique_code");
                      await const FlutterSecureStorage().delete(key: "roomId");

                      Navigator.pop(context);
                      String? jwt =
                          await const FlutterSecureStorage().read(key: 'jwt');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(jwt: jwt),
                        ),
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: red,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Duty Not Approved',
                                        textScaler: TextScaler.linear(1),
                                        style: TextStyle(
                                            fontSize: fontMedium,
                                            color: white,
                                            fontWeight: FontWeight.bold)),
                                    GestureDetector(
                                      onTap: () async {
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(
                                        Icons.close_sharp,
                                        color: white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                    'Duty rejected for this room. Please scan the QR code again for new room allocation.',
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: fontMedium,
                                      color: white,
                                    )),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: red,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Not Approved',
                                        textScaler: TextScaler.linear(1),
                                        style: TextStyle(
                                            fontSize: fontMedium,
                                            color: white,
                                            fontWeight: FontWeight.bold)),
                                    GestureDetector(
                                      onTap: () => Navigator.pop(context),
                                      child: const Icon(
                                        Icons.close_sharp,
                                        color: white,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                    'Please wait for the controller to approve your invigilation and try again.',
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                      fontSize: fontMedium,
                                      color: white,
                                    )),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  } catch (e) {
                    errorDialog(context, e.toString());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange, // Background color
                  foregroundColor: white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Request for Approval',
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(fontSize: fontMedium),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
