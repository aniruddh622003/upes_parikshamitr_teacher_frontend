// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';

import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/accept_bundle_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_bundle_data.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';

class EvaluationPage extends StatefulWidget {
  const EvaluationPage({super.key});

  @override
  State<EvaluationPage> createState() => _EvaluationPageState();
}

class _EvaluationPageState extends State<EvaluationPage> {
  List sheetsData = [];
  Timer? timer;
  bool isPageLoaded = false;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: timerDuration), (Timer t) async {
      await getSheetsData();
      setState(() {});
    });
  }

  Future<List> getSheetsData() async {
    dynamic response = await getBundleData();
    if (response.statusCode == 200) {
      sheetsData = jsonDecode(response.body)['data'];
    }
    return sheetsData;
  }

  List<Widget> makeBatchwiseBars(Map sheetData) {
    List<Widget> batchwiseBars = [];
    List batches = sheetData['copies'];

    for (var batch in batches) {
      String statusText = "";
      Color bubbleColor = green;
      if (batch['status'] == 'SUBMITTED') {
        statusText = "Submitted";
      } else if (batch['status'] == 'ALLOTTED' ||
          batch['status'] == 'ALLOTED') {
        statusText = "Requesting Allocation";
        bubbleColor = orange;
      } else if (batch['status'] == 'AVAILABLE') {
        statusText = "Sheets Available at ${sheetData['room_no']}";
        bubbleColor = Colors.purple;
      } else if (batch['status'] == 'OVERDUE') {
        statusText = "${batch['due_in']}";
        bubbleColor = red;
      } else if (batch['status'] == 'INPROGRESS') {
        statusText = "${batch['due_in']}";
        bubbleColor = blue;
      }
      batchwiseBars.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${batch['program']} ${batch['batch']}',
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(
                          fontSize: fontMedium,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(statusText),
                    ],
                  ),
                ),
                Container(
                  width: 65,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  decoration: BoxDecoration(
                    color: bubbleColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      batch['no_of_students'].toString(),
                      textScaler: const TextScaler.linear(1),
                      style: const TextStyle(
                        color: white,
                        fontSize: fontSmall + 3,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            const Divider(color: gray),
          ],
        ),
      );
      batchwiseBars.add(const SizedBox(width: 10));
    }
    return batchwiseBars;
  }

  List<Widget> makeSheetCards(List<dynamic> sheetsData) {
    List<Widget> sheetCards = [];
    sheetCards.add(const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [],
    ));

    if (sheetsData.isEmpty) {
      sheetCards.add(const SizedBox(height: 10));
      sheetCards.add(
        const Text(
          "No sheets to evaluate!",
          textScaler: TextScaler.linear(1),
          style: TextStyle(fontSize: fontMedium),
        ),
      );
      return sheetCards;
    }

    for (var sheetData in sheetsData) {
      bool isEnabled = false;
      for (var copy in sheetData['copies']) {
        if (copy['status'] == 'ALLOTTED') {
          isEnabled = true;
          break;
        }
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
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sheetData['subject_code'].toString(),
                      textScaler: const TextScaler.linear(1),
                    ),
                    Text(
                      sheetData['subject_school'].toString(),
                      textScaler: const TextScaler.linear(1),
                    ),
                    Text(
                      sheetData['subject_name'].toString(),
                      textScaler: const TextScaler.linear(1),
                      style: const TextStyle(
                          fontSize: fontMedium, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              isEnabled
                  ? Container(
                      width: 150,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: orange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          try {
                            acceptBundlePopup(context, sheetData);
                          } catch (e) {
                            errorDialog(context, e.toString());
                          }
                        },
                        child: const Center(
                          child: Text(
                            "Confirm Allotment",
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              color: white,
                              fontSize: fontSmall - 1,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          const Divider(color: gray),
          Column(children: makeBatchwiseBars(sheetData)),
        ]),
      ));
      sheetCards.add(const SizedBox(height: 10));
    }
    return sheetCards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: white,
        backgroundColor: blue,
        title: const Text('Evaluation Page'),
      ),
      body: FutureBuilder(
        future: getSheetsData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              !isPageLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              isPageLoaded = true;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView(
                  children: makeSheetCards(snapshot.data),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
