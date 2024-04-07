import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/seating_plan_popup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SeatingArrangement extends StatefulWidget {
  final String roomId;
  const SeatingArrangement({super.key, required this.roomId});

  @override
  State<SeatingArrangement> createState() => _SeatingArrangementState();
}

class _SeatingArrangementState extends State<SeatingArrangement> {
  late dynamic response;
  Map? seatingPlan;
  late Timer _timer;
  final ScrollController _scrollController = ScrollController();

  Key key = UniqueKey();

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      fetchData().then((value) {
        setState(() {
          seatingPlan = value;
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<Map> fetchData() async {
    response = await http.get(Uri.parse(
        '$serverUrl/teacher/invigilation/seating-plan?room_id=${widget.roomId}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
        key: key,
        child: FutureBuilder(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                seatingPlan == null) {
              return const Scaffold(
                  body: Center(
                child: CircularProgressIndicator(),
              )); // Show a loading spinner while waiting for fetchData to complete
            } else if (snapshot.hasError) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Error',
                      textScaler: TextScaler.linear(1),
                    ),
                    content: Text(
                      '${snapshot.error}',
                      textScaler: const TextScaler.linear(1),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text(
                          'OK',
                          textScaler: TextScaler.linear(1),
                        ),
                        onPressed: () {
                          try {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          } catch (e) {
                            errorDialog(context, e.toString());
                          }
                        },
                      ),
                    ],
                  ),
                );
              });
              return Container(
                color: Colors.blue,
              );
            } else {
              seatingPlan = snapshot.data;
              int countufm = 0;
              // Assign the data from fetchData to seatingPlan
              for (var student in seatingPlan?['data']['seating_plan']) {
                if (student['eligible'] == 'UFM') {
                  student['eligible'] = 'UFM';
                  countufm += 1;
                }
              }
              int allocatedStudents = seatingPlan?['data']['eligible_students'];
              int debarredStudents = seatingPlan?['data']['debarred_students'];
              int financialHoldStudents =
                  seatingPlan?['data']['f_hold_students'];
              int registrationHoldStudents =
                  seatingPlan?['data']['r_hold_students'];
              int presentStudents = seatingPlan?['data']['seating_plan']
                      .where((student) => student['attendance'] == true)
                      .length -
                  countufm;
              int totalSeats = ((int.parse(seatingPlan?['data']
                              ['highest_seat_no']
                          .substring(1)) +
                      0) *
                  (seatingPlan?['data']['highest_seat_no'].codeUnitAt(0) -
                      'A'.codeUnitAt(0) +
                      1)) as int;
              int emptySeats =
                  totalSeats - seatingPlan?['data']['total_students'] as int;

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
                        'Seating Arrangement',
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
                body: RefreshIndicator(
                  onRefresh: fetchData,
                  child: Column(
                    children: [
                      Center(
                        child: Text("Room: ${seatingPlan?['data']['room_no']}",
                            textScaler: const TextScaler.linear(1),
                            style: const TextStyle(
                              color: white,
                              fontSize: fontXLarge,
                            )),
                      ),
                      const SizedBox(height: 20),
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
                        child: ListView(children: [
                          SizedBox(
                            height: ((seatingPlan?['data']['highest_seat_no']
                                            .codeUnitAt(0) -
                                        'A'.codeUnitAt(0) +
                                        2) *
                                    60)
                                .toDouble(),
                            child: Scrollbar(
                              controller:
                                  _scrollController, // Pass the ScrollController to the Scrollbar
                              // interactive: true,
                              thickness: kIsWeb ? 15 : 0,
                              thumbVisibility: kIsWeb,
                              trackVisibility: kIsWeb,
                              child: GridView.builder(
                                controller: _scrollController,
                                scrollDirection: Axis.horizontal,
                                // shrinkWrap: true,
                                // physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 20),
                                itemCount: ((int.parse(seatingPlan?['data']
                                                ['highest_seat_no']
                                            .substring(1)) +
                                        1) *
                                    (seatingPlan?['data']['highest_seat_no']
                                            .codeUnitAt(0) -
                                        'A'.codeUnitAt(0) +
                                        2)) as int,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: (seatingPlan?['data']
                                              ['highest_seat_no']
                                          .codeUnitAt(0) -
                                      'A'.codeUnitAt(0) +
                                      2) as int,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  String highestSeat =
                                      seatingPlan?['data']['highest_seat_no'];
                                  int classSizeH = highestSeat.codeUnitAt(0) -
                                      'A'.codeUnitAt(0) +
                                      2;

                                  // int classSizeW =
                                  //     int.parse(highestSeat.substring(1));
                                  // int currentRow = index ~/ classSizeW + 1;
                                  Color color = blue;
                                  Color fontColor = black;
                                  String text = '';
                                  String seat = String.fromCharCode(
                                          64 + index % classSizeH) +
                                      (index ~/ classSizeH).toString();
                                  int indexData = seatingPlan?['data']
                                          ['seating_plan']
                                      .indexWhere((student) =>
                                          student['seat_no'] == seat);
                                  if (index == 0) {
                                    color = Colors.transparent;
                                  } else if (index < classSizeH) {
                                    text = String.fromCharCode(64 + index);
                                    color = Colors.transparent;
                                  } else if (index % classSizeH == 0) {
                                    color = Colors.transparent;
                                    if (index % classSizeH == 0) {
                                      text = (index ~/ classSizeH).toString();
                                    }
                                  } else if (indexData > -1) {
                                    if (seatingPlan?['data']['seating_plan']
                                            [indexData]['eligible'] ==
                                        'YES') {
                                      if (seatingPlan?['data']['seating_plan']
                                              [indexData]['attendance'] ==
                                          true) {
                                        color = green;
                                      } else {
                                        color = blue;
                                      }
                                    } else if (seatingPlan?['data']
                                                ['seating_plan'][indexData]
                                            ['eligible'] ==
                                        "UFM") {
                                      color = magenta;
                                    } else if (seatingPlan?['data']
                                                ['seating_plan'][indexData]
                                            ['eligible'] ==
                                        'DEBARRED') {
                                      color = red;
                                    } else if (seatingPlan?['data']
                                                ['seating_plan'][indexData]
                                            ['eligible'] ==
                                        'F_HOLD') {
                                      color = yellow;
                                    } else if (seatingPlan?['data']
                                                ['seating_plan'][indexData]
                                            ['eligible'] ==
                                        'R_HOLD') {
                                      color = orange;
                                    }
                                  } else {
                                    color = gray;
                                  }

                                  return GestureDetector(
                                    onTap: () => indexData > -1
                                        ? seatingPlanPopup(
                                            context,
                                            seatingPlan?['data']['seating_plan']
                                                [indexData])
                                        : {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: color,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(text.toString(),
                                            textScaler:
                                                const TextScaler.linear(1),
                                            style: TextStyle(
                                                color: fontColor,
                                                fontSize: fontMedium)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Total Students: ${seatingPlan?['data']['total_students']}',
                              textScaler: const TextScaler.linear(1),
                              style: const TextStyle(
                                color: black,
                                fontSize: fontMedium,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 1.3,
                            child: GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio: 2.5,
                              crossAxisCount: 2,
                              padding: const EdgeInsets.all(8.0),
                              children: [
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: blue,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                            child: Text(
                                          'Allocated: $allocatedStudents',
                                          textScaler:
                                              const TextScaler.linear(1),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: gray,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                            child: Text(
                                          'Unallocated: $emptySeats',
                                          textScaler:
                                              const TextScaler.linear(1),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: green,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                            child: Text(
                                          'Present: $presentStudents',
                                          textScaler:
                                              const TextScaler.linear(1),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: red,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                            child: Text(
                                          'Debarred: $debarredStudents',
                                          textScaler:
                                              const TextScaler.linear(1),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: yellow,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                            child: Text(
                                          'Financial\nHold: $financialHoldStudents',
                                          textScaler:
                                              const TextScaler.linear(1),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: orange,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                            child: Text(
                                          'Registration\nHold: $registrationHoldStudents',
                                          textScaler:
                                              const TextScaler.linear(1),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: magenta,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                            child: Text(
                                          'UFM issued: $countufm',
                                          textScaler:
                                              const TextScaler.linear(1),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ))
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
