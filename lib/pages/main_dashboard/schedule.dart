// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});
  @override
  _Schedule createState() => _Schedule();
}

class _Schedule extends State<Schedule> {
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Column(
          children: [
            Text(
              "Please find the Guidelines below for each role.",
              textScaler: TextScaler.linear(1),
              style: TextStyle(fontSize: 20, color: black),
            ),
            SizedBox(height: 20),
          ],
        ),
        const Text(
          "Instructions",
          textScaler: TextScaler.linear(1),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontMedium),
        ),
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(
                      double.infinity, 60), // Set a minimum height here
                ),
                onPressed: () async {
                  try {
                    // Load the PDF file from the assets
                    ByteData data = await rootBundle.load(
                        'assets/Examination Guidelines for Control Room Supervisors (CRS).pdf');

                    // Get the application documents directory
                    Directory appDocDir =
                        await getApplicationDocumentsDirectory();
                    String appDocPath = appDocDir.path;

                    // Write the file
                    File file = File(
                        '$appDocPath/Examination Guidelines for Control Room Supervisors (CRS).pdf');
                    await file.writeAsBytes(data.buffer
                        .asUint8List(data.offsetInBytes, data.lengthInBytes));

                    // Open the file
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                              title: const Text("Control Room Guidlines",
                                  textScaler: TextScaler.linear(1))),
                          body: PDFView(
                            filePath: file.path,
                          ),
                        ),
                      ),
                    );
                  } catch (e) {
                    errorDialog(context, e.toString());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 50,
                      color: white,
                    ), // Add your icon here
                    const SizedBox(width: 10),
                    // Add some spacing between the icon and text
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10), // Add left margin here
                        child: const Text('Control room instructions',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 20,
                              color: white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(
                      double.infinity, 60), // Set a minimum height here
                ),
                onPressed: () async {
                  try {
                    // Load the PDF file from the assets
                    ByteData data = await rootBundle.load(
                        'assets/Examination Guidelines for Flying Squad.pdf');

                    // Get the application documents directory
                    Directory appDocDir =
                        await getApplicationDocumentsDirectory();
                    String appDocPath = appDocDir.path;

                    // Write the file
                    File file = File(
                        '$appDocPath/Examination Guidelines for Flying Squad.pdf');
                    await file.writeAsBytes(data.buffer
                        .asUint8List(data.offsetInBytes, data.lengthInBytes));

                    // Open the file
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                              title: const Text(
                            "Flying Squad Guidlines",
                            textScaler: TextScaler.linear(1),
                          )),
                          body: PDFView(
                            filePath: file.path,
                          ),
                        ),
                      ),
                    );
                  } catch (e) {
                    errorDialog(context, e.toString());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 50,
                      color: white,
                    ), // Add your icon here
                    const SizedBox(width: 10),
                    // Add some spacing between the icon and text
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10), // Add left margin here
                        child: const Text('Flying Squad instructions',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 20,
                              color: white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(
                      double.infinity, 60), // Set a minimum height here
                ),
                onPressed: () async {
                  try {
                    // Load the PDF file from the assets
                    ByteData data = await rootBundle.load(
                        'assets/Examination Guidelines for Invigilators.pdf');

                    // Get the application documents directory
                    Directory appDocDir =
                        await getApplicationDocumentsDirectory();
                    String appDocPath = appDocDir.path;

                    // Write the file
                    File file = File(
                        '$appDocPath/Examination Guidelines for Invigilators.pdf');
                    await file.writeAsBytes(data.buffer
                        .asUint8List(data.offsetInBytes, data.lengthInBytes));

                    // Open the file
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                              title: const Text(
                            "Invigilator Guidlines",
                            textScaler: TextScaler.linear(1),
                          )),
                          body: PDFView(
                            filePath: file.path,
                          ),
                        ),
                      ),
                    );
                  } catch (e) {
                    errorDialog(context, e.toString());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 50,
                      color: white,
                    ), // Add your icon here
                    const SizedBox(width: 10),
                    // Add some spacing between the icon and text
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10), // Add left margin here
                        child: const Text('Invigilator instructions',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 20,
                              color: white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(
                      double.infinity, 60), // Set a minimum height here
                ),
                onPressed: () async {
                  try {
                    // Load the PDF file from the assets
                    ByteData data = await rootBundle
                        .load('assets/Answer Sheet Submission Guidelines.pdf');

                    // Get the application documents directory
                    Directory appDocDir =
                        await getApplicationDocumentsDirectory();
                    String appDocPath = appDocDir.path;

                    // Write the file
                    File file = File(
                        '$appDocPath/Answer Sheet Submission Guidelines.pdf');
                    await file.writeAsBytes(data.buffer
                        .asUint8List(data.offsetInBytes, data.lengthInBytes));

                    // Open the file
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Scaffold(
                          appBar: AppBar(
                              title: const Text(
                            "Answer Sheet Submission Guidelines",
                            textScaler: TextScaler.linear(1),
                          )),
                          body: PDFView(
                            filePath: file.path,
                          ),
                        ),
                      ),
                    );
                  } catch (e) {
                    errorDialog(context, e.toString());
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.picture_as_pdf,
                      size: 50,
                      color: white,
                    ), // Add your icon here
                    const SizedBox(width: 10),
                    // Add some spacing between the icon and text
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 10), // Add left margin here
                        child: const Text('Answer Sheet Submission',
                            textScaler: TextScaler.linear(1),
                            style: TextStyle(
                              fontSize: 20,
                              color: white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // SizedBox(
        //   height: 100,
        //   child: ListView(
        //     scrollDirection: Axis.horizontal,
        //     children: makeDateWidgets(dateData.keys.toList()),
        //   ),
        // ),
        // Column(
        //   children: List<Widget>.generate(
        //     data.length, // Replace with your number of containers
        //     (index) {
        //       Color selectedColorBG = purple;
        //       Color baseColorBG = purpleLight;
        //       Color selectedColorText = white;
        //       Color baseColorText = black;
        //       Color bgColor = (selectedContainerIndex == index)
        //           ? selectedColorBG
        //           : baseColorBG;
        //       Color textColor = (selectedContainerIndex == index)
        //           ? selectedColorText
        //           : baseColorText;
        //       Widget contents = (selectedContainerIndex == index)
        //           ? Container(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 15, vertical: 10),
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       Text(
        //                         data[index]['timeSlot'],
        //textScaler: const TextScaler.linear(1),
        //                         style: TextStyle(
        //                           color: textColor,
        //                           fontSize: fontSmall,
        //                         ),
        //                       ),
        //                       Text(
        //                         data[index]['room'],
        //textScaler: const TextScaler.linear(1),
        //                         style: TextStyle(
        //                           color: textColor,
        //                           fontSize: fontSmall,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   Text(
        //                     data[index]['task'],
        //textScaler: const TextScaler.linear(1),
        //                     style: TextStyle(
        //                       color: textColor,
        //                       fontSize: fontMedium,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                   Text(
        //                     '${data[index]['message']}',
        //textScaler: const TextScaler.linear(1),
        //                     style: TextStyle(
        //                       color: textColor,
        //                       fontSize: fontSmall,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             )
        //           : Container(
        //               padding: const EdgeInsets.symmetric(
        //                   horizontal: 15, vertical: 10),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 children: [
        //                   Text(
        //                     data[index]['timeSlot'],
        //textScaler: const TextScaler.linear(1),
        //                     style: TextStyle(
        //                       color: textColor,
        //                       fontSize: fontMedium,
        //                     ),
        //                   ),
        //                   Text(
        //                     data[index]['task'],
        //textScaler: const TextScaler.linear(1),
        //                     style: TextStyle(
        //                       color: textColor,
        //                       fontSize: fontMedium,
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             );
        //       return GestureDetector(
        //         onTap: () {
        //           setState(() {
        //             selectedContainerIndex = index;
        //           });
        //         },
        //         child: Container(
        //             margin: const EdgeInsets.only(top: 5),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               color: bgColor,
        //             ),
        //             child: contents),
        //       );
        //     },
        //   ),
        // ),
      ],
    );
  }
}
