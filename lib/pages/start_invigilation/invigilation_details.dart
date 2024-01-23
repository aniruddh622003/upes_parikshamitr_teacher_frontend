import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/start_invigilation/invigilation_details_card.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class InvigilationDetails extends StatelessWidget {
  InvigilationDetails({super.key});
  final List<bool> isSelected = [false, false, false];
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
            style: TextStyle(
              color: white,
            ),
          ),
          backgroundColor: blue,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: blue,
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome, <username>',
                  style: TextStyle(
                    color: white,
                    fontSize: fontMedium,
                  ),
                ),
              ),
            ),
            const InvigilationDetailsCard(),
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Dialog(
                            insetPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Confirm Invigilation',
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: fontLarge,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Please ensure that you have the following:',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: fontMedium,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelected[0] = !isSelected[0];
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isSelected[0]
                                            ? greenLight
                                            : blueLight,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Answer Sheets',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: fontMedium,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '24 Nos.',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: fontMedium,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelected[1] = !isSelected[1];
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isSelected[1]
                                            ? greenLight
                                            : blueLight,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Neural Network Question Papers',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: fontMedium,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '12 Nos.',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: fontMedium,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSelected[2] = !isSelected[2];
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: isSelected[2]
                                            ? greenLight
                                            : blueLight,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Containerization and Virtualization Technologies Question Papers',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: fontMedium,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '10 Nos.',
                                            style: TextStyle(
                                              color: white,
                                              fontSize: fontMedium,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: isSelected.contains(false)
                                        ? null
                                        : () {
                                            // Handle button press
                                          },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              isSelected.contains(false)
                                                  ? gray
                                                  : orange),
                                    ),
                                    child: const Text(
                                      'Confirm and Start Invigilation',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(orange),
                                    ),
                                    child: const Text(
                                      'Back',
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
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
                      style: TextStyle(fontSize: fontMedium),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const Dashboard()),
                  // );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent, // Background color
                  foregroundColor: white, // Text color
                  side: const BorderSide(
                      color: white, width: 2), // Border color and width
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Change Invigilation (3 left)',
                      style: TextStyle(fontSize: fontMedium),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
