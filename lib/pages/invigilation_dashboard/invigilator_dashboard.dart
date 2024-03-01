// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_supplies.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/pending_supplies_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/progress_bar.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/seating_arrangement.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/submit_to_controller.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/current_time.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class InvigilatorDashboard extends StatefulWidget {
  const InvigilatorDashboard({super.key});

  @override
  State<InvigilatorDashboard> createState() => _InvigilatorDashboardState();
}

class _InvigilatorDashboardState extends State<InvigilatorDashboard> {
  Map data = {};
  Future<Map> getDetails() async {
    final String? jwt = await const FlutterSecureStorage().read(key: 'jwt');
    var response = await http.get(
      Uri.parse('$serverUrl/teacher/getDetails'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['data'];
      setState(() {});
    } else {
      data = {'name': 'Default'};
    }
    return {};
  }

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Future<Widget> makePendingItems() async {
    // const storage = FlutterSecureStorage();
    // String? pendingSupplies = await storage.read(key: 'pendingSupplies');
    dynamic response = await getSupplies();
    List pendingSupplies = jsonDecode(response.body)['data'];
    List<Widget> items = [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: const Text(
          textScaler: TextScaler.linear(1),
          'Check Supplies',
          style: TextStyle(color: white),
        ),
      )
    ];
    List<dynamic> suppliesList = pendingSupplies;
    if (suppliesList.isEmpty) {
      items.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(
              color: gray,
            ),
          ),
          color: grayLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Text(
                textScaler: TextScaler.linear(1),
                'No pending supplies',
                style: TextStyle(
                  fontSize: fontSmall,
                ),
              ),
            ),
          ],
        ),
      ));
    } else {
      for (Map item in suppliesList) {
        if (item['quantity'] == 0) {
          continue;
        } else {
          items.add(Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: const Border(
                bottom: BorderSide(
                  color: gray,
                ),
              ),
              color: grayLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item['type'],
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontSmall,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: item['quantity'] > 0
                        ? () {
                            pendingSuppliesPopup(context, item, suppliesList);
                          }
                        : null,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors
                                .transparent; // Use the same background color when the button is disabled
                          }
                          return item['quantity'] > 0
                              ? Colors.orange
                              : Colors.transparent;
                        },
                      ),
                      foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors
                                .green; // Use the same text color when the button is disabled
                          }
                          return Colors.white;
                        },
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              10.0), // Change this to your desired border radius
                        ),
                      ),
                    ),
                    child: Text(
                      textScaler: const TextScaler.linear(1),
                      "Pending: ${item['quantity']}",
                      style: const TextStyle(
                        fontSize: fontSmall,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ));
        }
      }
    }

    if (items.length == 1) {
      items.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(
              color: gray,
            ),
          ),
          color: grayLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Text(
                textScaler: TextScaler.linear(1),
                'No pending supplies',
                style: TextStyle(
                  fontSize: fontSmall,
                ),
              ),
            ),
          ],
        ),
      ));
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: grayLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: const Text(
            textScaler: TextScaler.linear(1),
            'Invigilation Dashboard',
            style: TextStyle(
              fontSize: fontMedium,
              fontWeight: FontWeight.bold,
              color: white,
            ),
          ),
          backgroundColor: blue,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: white,
              ),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Text(data['name'] ?? 'Default',
                textScaler: const TextScaler.linear(1),
                style: const TextStyle(color: white, fontSize: fontLarge)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Column(
                    children: [
                      const CurrentTimeWidget(),
                      getPhaseText(),
                    ],
                  ),
                )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 14),
              child: InvigilatorProgress(),
            ),
            Expanded(
              child: Container(
                // width: double.infinity,
                padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                              onTap: () => errorDialog(context,
                                  "This feature is currently under development."),
                              // ufmPopup(context),
                              child:
                                  SvgPicture.asset('android/assets/ufm.svg')),
                        ),
                        Expanded(
                          child: GestureDetector(
                              onTap: () => errorDialog(context,
                                  "This feature is currently under development."),
                              // bsheetPopup(context),
                              child: SvgPicture.asset(
                                  'android/assets/supplementary.svg')),
                        ),
                        Expanded(
                          child: GestureDetector(
                              onTap: () async {
                                dynamic response = await getSupplies();
                                List<dynamic> suppliesList =
                                    jsonDecode(response.body)['data'];
                                for (Map item in suppliesList) {
                                  if (item['quantity'] != 0) {
                                    errorDialog(context,
                                        "Please clear all the pending supplies");
                                    return;
                                  }
                                }
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SubmitToController()));
                              },
                              child: SvgPicture.asset(
                                  'android/assets/controller.svg')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () => errorDialog(context,
                              "This feature is currently under development."),
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             const DoubtSection(roomNumber: "1101"))),
                          child: SvgPicture.asset('android/assets/doubt.svg'),
                        )),
                        Expanded(
                            child: GestureDetector(
                          onTap: () => attendancePopup(context),
                          child: SvgPicture.asset('android/assets/qr.svg'),
                        )),
                        Expanded(
                            child: GestureDetector(
                          onTap: () async {
                            try {
                              const storage = FlutterSecureStorage();
                              dynamic roomData =
                                  await storage.read(key: 'room_data');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SeatingArrangement(
                                            roomId: jsonDecode(
                                                    roomData.toString())[0]
                                                ['room_id'],
                                          )));
                            } catch (e) {
                              errorDialog(context, e.toString());
                            }
                          },
                          child: SvgPicture.asset(
                              'android/assets/seatingplan.svg'),
                        )),
                      ],
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(right: 20, left: 20, top: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: grayLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: const BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  textScaler: TextScaler.linear(1),
                                  'Flying Squad',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: fontSmall,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                // const Spacer(),
                                // Container(
                                //   padding: const EdgeInsets.only(right: 7),
                                //   child: SvgPicture.asset(
                                //       'android/assets/refresh.svg'),
                                // ),
                                // const Text(
                                //   "Refresh",
                                //   style: TextStyle(
                                //       fontSize: fontXSmall,
                                //       color: Colors.white),
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                  color: gray,
                                ),
                              ),
                              color: grayLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    textScaler: TextScaler.linear(1),
                                    'Dr. Rajat Gupta',
                                    style: TextStyle(
                                      fontSize: fontSmall,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                  color: gray,
                                ),
                              ),
                              color: grayLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    textScaler: TextScaler.linear(1),
                                    'Dr. Anil Kumar',
                                    style: TextStyle(
                                      fontSize: fontSmall,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                  color: gray,
                                ),
                              ),
                              color: grayLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    textScaler: TextScaler.linear(1),
                                    'Dr. Atul Kumar',
                                    style: TextStyle(
                                      fontSize: fontSmall,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    FutureBuilder<Widget>(
                      future: makePendingItems(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator(); // or some other widget while waiting
                        } else if (snapshot.hasError) {
                          return Text(
                              textScaler: const TextScaler.linear(1),
                              'Error: ${snapshot.error}');
                        } else {
                          return snapshot.data!;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget getPhaseText() {
    DateTime currentTime = DateTime.now();
    int currentHour = currentTime.hour;
    String period = currentHour >= 12 ? 'PM' : 'AM';

    if (currentHour >= 8 && currentHour < 13 && period == 'AM') {
      return const Text(
        textScaler: TextScaler.linear(1),
        '(Phase I)',
        style: TextStyle(
          fontSize: fontMedium,
          color: white,
          fontWeight: FontWeight.normal,
        ),
      );
    } else {
      return const Text(
        textScaler: TextScaler.linear(1),
        '(Phase II)',
        style: TextStyle(
          fontSize: fontMedium,
          color: white,
          fontWeight: FontWeight.normal,
        ),
      );
    }
  }
}
