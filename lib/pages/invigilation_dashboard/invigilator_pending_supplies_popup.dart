import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class Test extends StatelessWidget {
  const Test({super.key});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: orange,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                  textScaler: TextScaler.linear(1),
                  'Pending Supplies',
                  style: TextStyle(
                      fontSize: fontMedium,
                      color: white,
                      fontWeight: FontWeight.bold)),
              Container(
                width: 35,
                height: 35,
                decoration: const BoxDecoration(
                  color: white,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    textScaler: TextScaler.linear(1),
                    "!",
                    style: TextStyle(
                      color: orange,
                      fontSize: fontMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
              textScaler: TextScaler.linear(1),
              'There are still some items left that you haven’t received, please confirm them below and get started with invigilation while they arrive to your assigned room.',
              style: TextStyle(
                fontSize: fontSmall,
                color: white,
              )),
          const SizedBox(height: 10),
          Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      textScaler: TextScaler.linear(1),
                      '\u2022 B-Sheets',
                      style: TextStyle(
                          fontSize: fontMedium,
                          color: white,
                          fontWeight: FontWeight.bold)),
                  Text(
                      textScaler: TextScaler.linear(1),
                      '10/55',
                      style: TextStyle(
                          fontSize: fontMedium,
                          color: white,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      textScaler: TextScaler.linear(1),
                      '\u2022 Threads',
                      style: TextStyle(
                          fontSize: fontMedium,
                          color: white,
                          fontWeight: FontWeight.bold)),
                  Text(
                      textScaler: TextScaler.linear(1),
                      '0/55',
                      style: TextStyle(
                          fontSize: fontMedium,
                          color: white,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      textScaler: TextScaler.linear(1),
                      '\u2022 Pink Slips',
                      style: TextStyle(
                          fontSize: fontMedium,
                          color: white,
                          fontWeight: FontWeight.bold)),
                  Text(
                      textScaler: TextScaler.linear(1),
                      '10/55',
                      style: TextStyle(
                          fontSize: fontMedium,
                          color: white,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: white,
                  foregroundColor: orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Handle button press here
                },
                child: const Text(
                  textScaler: TextScaler.linear(1),
                  'Request for Pending Supplies',
                  style: TextStyle(
                    color: orange,
                    fontSize: fontSmall,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
