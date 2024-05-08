// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_slot_details.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:intl/intl.dart';

class ViewDutyPage extends StatefulWidget {
  const ViewDutyPage({super.key});

  @override
  State<ViewDutyPage> createState() => _ViewDutyPageState();
}

class _ViewDutyPageState extends State<ViewDutyPage> {
  List data = [];
  Map dateData = {};

  bool isPageLoaded = false;

  String selectedMonth = 'None';
  String selectedYear = 'None';
  String selectedMonthDropDown = 'None';

  Map<String, String> monthNames = {
    '01': 'January',
    '02': 'February',
    '03': 'March',
    '04': 'April',
    '05': 'May',
    '06': 'June',
    '07': 'July',
    '08': 'August',
    '09': 'September',
    '10': 'October',
    '11': 'November',
    '12': 'December',
  };

  List<String> months = [
    'None',
  ];

  List<String> years = [
    'None',
  ];

  Future<Map<String, dynamic>> setSlotData() async {
    dynamic response = await getSlotDetails();

    if (response.statusCode == 200) {
      dateData = jsonDecode(response.body);

      var sortedEntries = dateData.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key));
      dateData = Map.fromEntries(sortedEntries);

      months = [];
      years = [];

      for (var date in dateData.keys) {
        List<String> dateParts = date.split('-');
        if (!months.contains(dateParts[1])) {
          months.add(dateParts[1]);
        }
        if (!years.contains(dateParts[0])) {
          years.add(dateParts[0]);
        }
      }
      months.sort();
      years.sort();
      months = ['None', ...months];
      years = ['None', ...years];
      months = months.map((e) => monthNames[e] ?? e).toList();
    } else {
      throw Exception("An error occurred while fetching duty data");
    }
    return Future.value({
      'dateData': dateData,
      'months': months,
      'years': years,
    });
  }

  @override
  void initState() {
    super.initState();
    setSlotData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int selectedContainerIndex = 0;
  String selectedDate = '';
  List<Widget> makeDateWidgets(List<dynamic> dates) {
    List<Widget> dateWidgets = [];
    for (var x in dates) {
      String date = x as String;
      if (date.split('-')[0] != selectedYear && selectedYear != 'None') {
        continue;
      }
      if (date.split('-')[1] != selectedMonth && selectedMonth != 'None') {
        continue;
      }
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
                  date.split('-')[2],
                  textScaler: const TextScaler.linear(1),
                  style: TextStyle(
                    color: textColor,
                    fontSize: fontLarge,
                  ),
                ),
                Text(
                  monthName,
                  textScaler: const TextScaler.linear(1),
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
    return FutureBuilder<Map<String, dynamic>>(
      future: setSlotData(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !isPageLoaded) {
          return Container(
            color: white,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          isPageLoaded = true;
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Month: ",
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                        fontSize: fontMedium,
                                      )),
                                  DropdownButton<String>(
                                    value: selectedMonthDropDown,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedMonthDropDown =
                                            newValue ?? selectedMonthDropDown;
                                        switch (selectedMonthDropDown) {
                                          case 'January':
                                            selectedMonth = '01';
                                            break;
                                          case 'February':
                                            selectedMonth = '02';
                                            break;
                                          case 'March':
                                            selectedMonth = '03';
                                            break;
                                          case 'April':
                                            selectedMonth = '04';
                                            break;
                                          case 'May':
                                            selectedMonth = '05';
                                            break;
                                          case 'June':
                                            selectedMonth = '06';
                                            break;
                                          case 'July':
                                            selectedMonth = '07';
                                            break;
                                          case 'August':
                                            selectedMonth = '08';
                                            break;
                                          case 'September':
                                            selectedMonth = '09';
                                            break;
                                          case 'October':
                                            selectedMonth = '10';
                                            break;
                                          case 'November':
                                            selectedMonth = '11';
                                            break;
                                          case 'December':
                                            selectedMonth = '12';
                                            break;
                                          default:
                                            selectedMonth = 'None';
                                        }
                                        data = [];
                                      });
                                    },
                                    items: months.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          textScaler:
                                              const TextScaler.linear(1),
                                          style: const TextStyle(
                                            fontSize: fontMedium,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(width: 10),
                                  const Text("Year: ",
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                        fontSize: fontMedium,
                                      )),
                                  DropdownButton<String>(
                                    value: selectedYear,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedYear = newValue ?? selectedYear;
                                        data = [];
                                      });
                                    },
                                    items: years.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              textScaler:
                                                  const TextScaler.linear(1),
                                              style: const TextStyle(
                                                  fontSize: fontMedium)));
                                    }).toList(),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 100,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children:
                                      makeDateWidgets(dateData.keys.toList()),
                                ),
                              ),
                              Column(
                                children: data.isEmpty
                                    ? <Widget>[
                                        const SizedBox(height: 20),
                                        const Center(
                                          child: Text(
                                            'Tap a date to view details',
                                            textScaler: TextScaler.linear(1),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: fontMedium,
                                            ),
                                          ),
                                        ),
                                      ]
                                    : List<Widget>.generate(
                                        data.length, // Replace with your number of containers
                                        (index) {
                                          Color selectedColorBG = purple;
                                          Color baseColorBG = purpleLight;
                                          Color selectedColorText = white;
                                          Color baseColorText = black;
                                          Color bgColor =
                                              (selectedContainerIndex == index)
                                                  ? selectedColorBG
                                                  : baseColorBG;
                                          Color textColor =
                                              (selectedContainerIndex == index)
                                                  ? selectedColorText
                                                  : baseColorText;
                                          Widget contents =
                                              (selectedContainerIndex == index)
                                                  ? Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15,
                                                          vertical: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                data[index]
                                                                    ['time'],
                                                                textScaler:
                                                                    const TextScaler
                                                                        .linear(
                                                                        1),
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontSize:
                                                                      fontSmall,
                                                                ),
                                                              ),
                                                              Text(
                                                                data[index]
                                                                    ['room'],
                                                                textScaler:
                                                                    const TextScaler
                                                                        .linear(
                                                                        1),
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      textColor,
                                                                  fontSize:
                                                                      fontSmall,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Text(
                                                            data[index]['type'],
                                                            textScaler:
                                                                const TextScaler
                                                                    .linear(1),
                                                            style: TextStyle(
                                                              color: textColor,
                                                              fontSize:
                                                                  fontMedium,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            '${data[index]['message']}',
                                                            textScaler:
                                                                const TextScaler
                                                                    .linear(1),
                                                            style: TextStyle(
                                                              color: textColor,
                                                              fontSize:
                                                                  fontSmall,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 15,
                                                          vertical: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            data[index]['time'],
                                                            textScaler:
                                                                const TextScaler
                                                                    .linear(1),
                                                            style: TextStyle(
                                                              color: textColor,
                                                              fontSize:
                                                                  fontMedium,
                                                            ),
                                                          ),
                                                          Text(
                                                            data[index]['type'],
                                                            textScaler:
                                                                const TextScaler
                                                                    .linear(1),
                                                            style: TextStyle(
                                                              color: textColor,
                                                              fontSize:
                                                                  fontMedium,
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
                                                margin: const EdgeInsets.only(
                                                    top: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: bgColor,
                                                ),
                                                child: contents),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          )
                        ],
                      )),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
