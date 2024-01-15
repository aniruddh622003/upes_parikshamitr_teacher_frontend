// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    '2024-01-13': [
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
    '2024-01-14': [
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
        backgroundColor = const Color(0xffE7F9E7);
        textColor = const Color(0xffF2692E);
      } else if (dateD.isAfter(now)) {
        backgroundColor = const Color(0xffE7E9F9);
        textColor = const Color(0xffF2692E);
      } else {
        backgroundColor = const Color(0xffF2692E);
        textColor = Colors.white;
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
                color: selectedDate == date ? Colors.grey : Colors.transparent,
                width: 2,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  date.split('-')[2],
                  style: TextStyle(
                    color: textColor,
                    fontSize: 25,
                  ),
                ),
                Text(
                  monthName,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
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
        const Text(
          "View Invigilation Schedule",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: makeDateWidgets(dateData.keys.toList()),
          ),
        ),
        Column(
          children: List<Widget>.generate(
            data.length, // Replace with your number of containers
            (index) {
              Color selectedColorBG = const Color(0xff6E83DB);
              Color baseColorBG = const Color(0xffC2C9F0);
              Color selectedColorText = const Color(0xffffffff);
              Color baseColorText = const Color(0xff000000);
              Color bgColor = (selectedContainerIndex == index)
                  ? selectedColorBG
                  : baseColorBG;
              Color textColor = (selectedContainerIndex == index)
                  ? selectedColorText
                  : baseColorText;
              Widget contents = (selectedContainerIndex == index)
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                data[index]['timeSlot'],
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                data[index]['room'],
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            data[index]['task'],
                            style: TextStyle(
                              color: textColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${data[index]['message']}',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            data[index]['timeSlot'],
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            data[index]['task'],
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    );
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedContainerIndex = index;
                  });
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: bgColor,
                    ),
                    child: contents),
              );
            },
          ),
        ),
      ],
    );
  }
}
