// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/ans_sheet_search.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';

class SearchSheet extends StatefulWidget {
  const SearchSheet({super.key});

  @override
  State<SearchSheet> createState() => _SearchSheetState();
}

class _SearchSheetState extends State<SearchSheet> {
  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController sheetController = TextEditingController();

  Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Search Sheet',
              textScaler: TextScaler.linear(1),
              style: TextStyle(color: white),
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: white),
          onPressed: () {
            try {
              Navigator.pop(context);
            } catch (e) {
              errorDialog(context, e.toString());
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: white,
                ),
                child: ListView(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: sheetController,
                                keyboardType:
                                    TextInputType.number, // Only accept digits
                                decoration: InputDecoration(
                                  hintText: "Enter Sheet Number",
                                  filled: true,
                                  fillColor: white,
                                  contentPadding: const EdgeInsets.all(10),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(color: blue),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(color: blue),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                                width:
                                    10), // Spacing between the text field and the button
                            ElevatedButton(
                              onPressed: () async {
                                if (sheetController.text.isEmpty) {
                                  errorDialog(
                                      context, "Please enter Sheet Number!");
                                } else {
                                  try {
                                    dynamic response = await ansSheetSearch(
                                      int.parse(
                                        sheetController.text,
                                      ),
                                    );
                                    if (response.statusCode == 200) {
                                      setState(() {
                                        data =
                                            jsonDecode(response.body)['data'];
                                      });
                                    } else {
                                      errorDialog(context, "Sheet not found!");
                                    }
                                  } catch (e) {
                                    errorDialog(context, e.toString());
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: blue, // Background color
                                foregroundColor: white, // Text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                              child: const Text('Search'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        data.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Sheet Details',
                                          textScaler: TextScaler.linear(1),
                                          style: TextStyle(
                                              fontSize: fontMedium,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('SAP ID',
                                          textScaler: TextScaler.linear(1),
                                          style: TextStyle(
                                              fontSize: fontSmall,
                                              color: blue,
                                              fontWeight: FontWeight.bold)),
                                      Text('Seat No.',
                                          textScaler: TextScaler.linear(1),
                                          style: TextStyle(
                                              fontSize: fontSmall,
                                              color: blue,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data['sap_id'].toString(),
                                          textScaler:
                                              const TextScaler.linear(1),
                                          style: const TextStyle(
                                              fontSize: fontMedium)),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: const BoxDecoration(
                                          color: blue,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            data['seat_no'].toString(),
                                            textScaler:
                                                const TextScaler.linear(1),
                                            style: const TextStyle(
                                              color: white,
                                              fontSize: fontMedium - 3,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const Text('Roll No.',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                          fontSize: fontSmall,
                                          color: blue,
                                          fontWeight: FontWeight.bold)),
                                  Text(data['roll_no'].toString(),
                                      textScaler: const TextScaler.linear(1),
                                      style: const TextStyle(
                                        fontSize: fontMedium,
                                      )),
                                  const Text('Name',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                          fontSize: fontSmall,
                                          color: blue,
                                          fontWeight: FontWeight.bold)),
                                  Text(data['student_name'].toString(),
                                      textScaler: const TextScaler.linear(1),
                                      style: const TextStyle(
                                        fontSize: fontMedium,
                                      )),
                                  const Text('Subject Name',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                          fontSize: fontSmall,
                                          color: blue,
                                          fontWeight: FontWeight.bold)),
                                  Text(data['subject'].toString(),
                                      textScaler: const TextScaler.linear(1),
                                      style: const TextStyle(
                                        fontSize: fontMedium,
                                      )),
                                  const Text('Subject Code',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                          fontSize: fontSmall,
                                          color: blue,
                                          fontWeight: FontWeight.bold)),
                                  Text(data['subject_code'].toString(),
                                      textScaler: const TextScaler.linear(1),
                                      style: const TextStyle(
                                        fontSize: fontMedium,
                                      )),
                                  const Text('Course',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                          fontSize: fontSmall,
                                          color: blue,
                                          fontWeight: FontWeight.bold)),
                                  Text(data['course'].toString(),
                                      textScaler: const TextScaler.linear(1),
                                      style: const TextStyle(
                                        fontSize: fontMedium,
                                      )),
                                  const Text('Examination Type',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                          fontSize: fontSmall,
                                          color: blue,
                                          fontWeight: FontWeight.bold)),
                                  Text(data['exam_type'].toString(),
                                      textScaler: const TextScaler.linear(1),
                                      style: const TextStyle(
                                        fontSize: fontMedium,
                                      )),
                                  const Text('A Sheet Number',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                          fontSize: fontSmall,
                                          color: blue,
                                          fontWeight: FontWeight.bold)),
                                  Text.rich(
                                    TextSpan(
                                      style: const TextStyle(
                                          fontFamily: 'fontMedium',
                                          fontSize:
                                              fontMedium), // Use the predefined font size
                                      children: [
                                        if (data['ans_sheet_number']
                                                .toString() ==
                                            'null')
                                          const TextSpan(text: 'Not Allotted')
                                        else if (data['UFM'] != null)
                                          if (data['new_ans_sheet_number'] ==
                                              null)
                                            const TextSpan(text: 'Cancelled')
                                          else
                                            TextSpan(
                                              children: [
                                                TextSpan(
                                                  text:
                                                      '${data['ans_sheet_number'].toString()} ',
                                                  style: const TextStyle(
                                                      decoration: TextDecoration
                                                          .lineThrough,
                                                      fontSize:
                                                          fontMedium), // Use the predefined font size
                                                ),
                                                const WidgetSpan(
                                                  child: SizedBox(
                                                      width:
                                                          5), // Add a gap between the two sheet numbers
                                                ),
                                                TextSpan(
                                                  text: data[
                                                          'new_ans_sheet_number']
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize:
                                                          fontMedium), // Use the predefined font size
                                                ),
                                              ],
                                            )
                                        else
                                          TextSpan(
                                              text: data['ans_sheet_number']
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontSize:
                                                      fontMedium)), // Use the predefined font size
                                      ],
                                    ),
                                  ), // Apply the TextScaler
                                  const Text('B Sheet Count',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                          fontSize: fontSmall,
                                          color: blue,
                                          fontWeight: FontWeight.bold)),
                                  Text(data['b_sheet_count'].toString(),
                                      textScaler: const TextScaler.linear(1),
                                      style: const TextStyle(
                                        fontSize: fontMedium,
                                      )),
                                  const Text('UFM',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                          fontSize: fontSmall,
                                          color: blue,
                                          fontWeight: FontWeight.bold)),
                                  Text(data['UFM'] == null ? 'No' : 'Yes',
                                      textScaler: const TextScaler.linear(1),
                                      style: const TextStyle(
                                        fontSize: fontMedium,
                                      )),
                                ],
                              )
                            : Container(),
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
