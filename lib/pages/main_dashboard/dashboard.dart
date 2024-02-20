// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_notifications.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login/home_activity.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/notification_screen.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/schedule.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/start_invigilation/start_invigilation.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  final String? jwt;
  const Dashboard({super.key, required this.jwt});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Map data;

  Future<Map> getDetails({token}) async {
    var response = await http.get(
      Uri.parse('$serverUrl/teacher/getDetails'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['data'];
    } else {
      errorDialog(context, 'Error occurred! Please try again later');
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeActivity()),
      );
    }
    return {};
  }

  @override
  void initState() {
    getDetails(token: widget.jwt);
    super.initState();
  }

  List<Widget> makeBatchwiseBars(List<Map<String, dynamic>> batches) {
    List<Widget> batchwiseBars = [];
    for (Map<String, dynamic> batch in batches) {
      batchwiseBars.add(
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${batch['name']}',
                  style: const TextStyle(
                    fontSize: fontMedium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${batch['sheetsEvaluated'].toString()}/${batch['totalSheets'].toString()}',
                  style: const TextStyle(
                    fontSize: fontMedium,
                  ),
                )
              ],
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                height: 8,
                child: LinearProgressIndicator(
                  value: batch['sheetsEvaluated'] / batch['totalSheets'],
                  backgroundColor: grayLight,
                  valueColor: const AlwaysStoppedAnimation<Color>(orange),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      );
      batchwiseBars.add(const SizedBox(width: 10));
    }
    return batchwiseBars;
  }

  final sheetsData = [
    {
      'subjectCode': 'CSBD1001',
      'subjectName': 'Big Data',
      'dueDate': '2024-01-15',
      'batches': [
        {'name': 'AIML B2 (NH)', 'totalSheets': 30, 'sheetsEvaluated': 10},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5}
      ]
    },
    {
      'subjectCode': 'CSAI2036',
      'subjectName': 'Machine Learning',
      'dueDate': '2024-01-20',
      'batches': [
        {'name': 'AIML B1 (NH)', 'totalSheets': 20, 'sheetsEvaluated': 10},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5}
      ]
    },
    {
      'subjectCode': 'CSAI1231',
      'subjectName': 'Deep Learning',
      'dueDate': '2024-01-25',
      'batches': [
        {'name': 'AIML B1 (NH)', 'totalSheets': 20, 'sheetsEvaluated': 10},
        {'name': 'AIML B3 (H)', 'totalSheets': 20, 'sheetsEvaluated': 5}
      ]
    }
  ];

  List<int> calcSheets(List<Map<String, dynamic>> sheetsData) {
    List<int> totalSheets = [];
    int total = 0;
    int checked = 0;
    for (Map<String, dynamic> sheetData in sheetsData) {
      for (var batch in sheetData['batches'] as List<Map<String, dynamic>>) {
        checked += batch['sheetsEvaluated'] as int;
        total += batch['totalSheets'] as int;
      }
    }
    totalSheets.add(checked);
    totalSheets.add(total);
    return totalSheets;
  }

  List<Widget> makeSheetCards(List<Map<String, dynamic>> sheetsData) {
    List<Widget> sheetCards = [];
    sheetCards.add(const Text("Evaluate Answer Sheets",
        style: TextStyle(fontWeight: FontWeight.bold)));
    for (Map<String, dynamic> sheetData in sheetsData) {
      final int daysRemaining = DateTime.parse(sheetData['dueDate'].toString())
          .difference(DateTime.now())
          .inDays;
      int totalSheets = 0;
      int sheetsEvaluated = 0;
      for (var batch in sheetData['batches'] as List<Map<String, dynamic>>) {
        totalSheets += batch['totalSheets'] as int;
        sheetsEvaluated += batch['sheetsEvaluated'] as int;
      }
      sheetCards.add(Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: purpleXLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sheetData['subjectCode'].toString()),
                  Text(
                    sheetData['subjectName'].toString(),
                    style: const TextStyle(
                        fontSize: fontMedium, fontWeight: FontWeight.bold),
                  ),
                  Text('Submission in $daysRemaining days'),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 8),
                decoration: BoxDecoration(
                  color: orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$sheetsEvaluated/$totalSheets',
                  style: const TextStyle(color: white),
                ),
              )
            ],
          ),
          const Divider(color: gray),
          Column(
              children: makeBatchwiseBars(
                  sheetData['batches'] as List<Map<String, dynamic>>)),
        ]),
      ));
      sheetCards.add(const SizedBox(height: 10));
    }
    return sheetCards;
  }

  Widget makeSheetMain(List<Map<String, dynamic>> sheetsData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: makeSheetCards(sheetsData),
    );
  }

  final storage = const FlutterSecureStorage();

  void signOut() async {
    final confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Sign Out'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirm) {
      await storage.delete(key: 'jwt');
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeActivity()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDetails(token: widget.jwt),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')));
        } else {
          return Scaffold(
              backgroundColor: blue,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: white),
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.logout, color: white),
                          onPressed: () {
                            signOut();
                          },
                        ),
                        const Text(
                          'Dashboard',
                          style: TextStyle(color: white),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.qr_code, color: white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartInvigilation()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Hi, ${data['name']}!',
                      style: const TextStyle(color: white, fontSize: fontLarge),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Column(
                  //   children: [
                  //     Container(
                  //       padding: const EdgeInsets.symmetric(horizontal: 15),
                  //       child: Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //               '${calcSheets(sheetsData)[0]}/${calcSheets(sheetsData)[1]} Sheets Checked',
                  //               style: const TextStyle(
                  //                   color: white, fontSize: fontSmall)),
                  //           ClipRRect(
                  //             borderRadius:
                  //                 const BorderRadius.all(Radius.circular(10)),
                  //             child: SizedBox(
                  //               height: 8,
                  //               child: LinearProgressIndicator(
                  //                 value: calcSheets(sheetsData)[0] /
                  //                     calcSheets(sheetsData)[1],
                  //                 backgroundColor: grayLight,
                  //                 valueColor:
                  //                     const AlwaysStoppedAnimation<Color>(orange),
                  //               ),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        decoration: const BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                onPressed: () async {
                                  dynamic response = await getNotifications();
                                  if (response.statusCode == 200) {
                                    print(jsonDecode(response.body)['data']
                                        ['notifications']);
                                    List<dynamic> notifications =
                                        jsonDecode(response.body)['data']
                                            ['notifications'];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NotificationScreen(
                                                  notifications:
                                                      notifications)),
                                    );
                                  } else {
                                    errorDialog(context,
                                        'Error occurred! Please try again later');
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    padding: const EdgeInsets.all(0)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        'View Notification',
                                        style: TextStyle(color: white),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Text(
                                        '3',
                                        style: TextStyle(color: white),
                                      ),
                                    ),
                                    const Spacer(),
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Schedule(),
                            const SizedBox(height: 10),
                            // makeSheetMain(sheetsData),
                          ],
                        )),
                  ),
                ],
              ));
        }
      },
    );
  }
}
