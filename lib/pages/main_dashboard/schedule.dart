// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});
  @override
  _Schedule createState() => _Schedule();
}

class _Schedule extends State<Schedule> {
  List<Map> data = [
    {
      'timeSlot': '9 AM - 12 PM',
      'task': 'Invigilation Duty',
      'room': 'Controller Room',
      'message':
          'Go to the controller room, press start invigilation and scan the QR for further  instructions'
    },
    {
      'timeSlot': '12 PM - 1 PM',
      'task': 'Lunch Break',
      'room': 'Cafeteria',
      'message':
          'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
    },
  ];

  Map dateData = {
    '2024-01-09': [
      {
        'timeSlot': '9 AM - 12 PM',
        'task': 'Invigilation Duty',
        'room': 'Controller Room',
        'message':
            'Go to the controller room, press start invigilation and scan the QR for further  instructions'
      },
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      }
    ],
    '2024-01-10': [
      {
        'timeSlot': '9 AM - 12 PM',
        'task': 'Invigilation Duty',
        'room': 'Controller Room',
        'message':
            'Go to the controller room, press start invigilation and scan the QR for further  instructions'
      }
    ],
    '2024-01-11': [
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      }
    ],
    '2024-01-12': [
      {
        'timeSlot': '9 AM - 12 PM',
        'task': 'Invigilation Duty',
        'room': 'Controller Room',
        'message':
            'Go to the controller room, press start invigilation and scan the QR for further  instructions'
      },
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      }
    ],
    '2024-01-16': [
      {
        'timeSlot': '9 AM - 12 PM',
        'task': 'Invigilation Duty',
        'room': 'Controller Room',
        'message':
            'Go to the controller room, press start invigilation and scan the QR for further  instructions'
      },
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      },
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      }
    ],
    '2024-01-17': [
      {
        'timeSlot': '9 AM - 12 PM',
        'task': 'Invigilation Duty',
        'room': 'Controller Room',
        'message':
            'Go to the controller room, press start invigilation and scan the QR for further  instructions'
      },
      {
        'timeSlot': '12 PM - 1 PM',
        'task': 'Lunch Break',
        'room': 'Cafeteria',
        'message':
            'Go to the cafeteria and have your lunch. You can also have a cup of coffee'
      }
    ],
  };

  int selectedContainerIndex = 0;
  String selectedDate = '';
  List<Widget> makeDateWidgets(List<dynamic> dates) {
    List<Widget> dateWidgets = [];
    for (var x in dates) {
      String date = x as String;
      Color backgroundColor;
      Color textColor;
      DateTime now = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      DateTime dateD = DateTime.parse(date);
      String monthName = DateFormat('MMM').format(DateTime(
          int.parse(date.split('-')[0]), int.parse(date.split('-')[1])));
      if (dateD.isBefore(now)) {
        backgroundColor = greenXLight;
        textColor = orange;
      } else if (dateD.isAfter(now)) {
        backgroundColor = blueXLight;
        textColor = orange;
      } else {
        backgroundColor = orange;
        textColor = white;
      }
      dateWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
              selectedContainerIndex = 0;
              data = dateData[date];
            });
          },
          child: Container(
            width: 65,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: selectedDate == date ? blue : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  textScaler: const TextScaler.linear(1),
                  date.split('-')[2],
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontLarge,
                  ),
                ),
                Text(
                  textScaler: const TextScaler.linear(1),
                  monthName,
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      dateWidgets.add(const SizedBox(width: 10));
    }
    return dateWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Text(textScaler: const TextScaler.linear(1),
        //   "View Invigilation Schedule",
        //   style: TextStyle(fontWeight: FontWeight.bold),
        // ),

        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: blue,
          ),
          child: const Column(
            children: [
              Text(
                textScaler: TextScaler.linear(1),
                "Welcome to UPES ParikshaMitr Teacher",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 30, color: white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                textScaler: TextScaler.linear(1),
                "Please Scan the QR by pressing the button on the top-right corner to start invigilation.",
                style: TextStyle(fontSize: 20, color: white),
              ),
            ],
          ),
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
        //                       Text(textScaler: const TextScaler.linear(1),
        //                         data[index]['timeSlot'],
        //                         style: TextStyle(
        //                           color: textColor,
        //                           fontSize: fontSmall,
        //                         ),
        //                       ),
        //                       Text(textScaler: const TextScaler.linear(1),
        //                         data[index]['room'],
        //                         style: TextStyle(
        //                           color: textColor,
        //                           fontSize: fontSmall,
        //                         ),
        //                       ),
        //                     ],
        //                   ),
        //                   Text(textScaler: const TextScaler.linear(1),
        //                     data[index]['task'],
        //                     style: TextStyle(
        //                       color: textColor,
        //                       fontSize: fontMedium,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                   Text(textScaler: const TextScaler.linear(1),
        //                     '${data[index]['message']}',
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
        //                   Text(textScaler: const TextScaler.linear(1),
        //                     data[index]['timeSlot'],
        //                     style: TextStyle(
        //                       color: textColor,
        //                       fontSize: fontMedium,
        //                     ),
        //                   ),
        //                   Text(textScaler: const TextScaler.linear(1),
        //                     data[index]['task'],
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
