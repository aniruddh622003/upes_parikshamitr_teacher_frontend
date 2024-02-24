import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
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

  @override
  void initState() {
    fetchData().then((value) {
      setState(() {
        seatingPlan = value;
      });
    });
    super.initState();
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
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading spinner while waiting for fetchData to complete
        } else if (snapshot.hasError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text('${snapshot.error}'),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          });
          return Container(
            color: Colors.blue,
          ); // Return an empty container as the builder has to return a widget
        } else {
          seatingPlan =
              snapshot.data; // Assign the data from fetchData to seatingPlan
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
                    style: TextStyle(color: white),
                  )
                ],
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: RefreshIndicator(
              onRefresh: fetchData,
              child: Column(
                children: [
                  Center(
                    child: Text("Room: ${seatingPlan?['data']['room_no']}",
                        style: const TextStyle(
                          color: white,
                          fontSize: fontXLarge,
                        )),
                  ),
                  const Center(
                    child: Text("2:00 - 5:00 PM",
                        style: TextStyle(
                          color: white,
                          fontSize: fontSmall,
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
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: int.parse(seatingPlan?['data']
                                      ['highest_seat_no']
                                  .substring(1)) +
                              1,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          String highestSeat =
                              seatingPlan?['data']['highest_seat_no'];
                          int classSizeH =
                              highestSeat.codeUnitAt(0) - 'A'.codeUnitAt(0) + 2;
                          int classSizeW =
                              int.parse(highestSeat.substring(1)) + 1;
                          int currentRow = index ~/ classSizeW + 1;
                          Color color = blue;
                          Color fontColor = black;
                          String text = '';
                          String seat = String.fromCharCode(
                                  64 + index ~/ classSizeW + 1) +
                              (index % classSizeW).toString();
                          int indexData = seatingPlan?['data']['seating_plan']
                              .indexWhere(
                                  (student) => student['seat_no'] == seat);

                          if (index == (classSizeH - 1) * classSizeW) {
                            color = Colors.transparent;
                          } else if (index % classSizeW == 0 ||
                              currentRow == classSizeH) {
                            color = Colors.transparent;
                            if (index % classSizeW == 0) {
                              text = String.fromCharCode(
                                  64 + index ~/ classSizeW + 1);
                            }
                            if (index > classSizeW * (classSizeH - 1)) {
                              text = (index - classSizeW * (classSizeH - 1))
                                  .toString();
                            }
                          } else if (indexData > -1) {
                            if (seatingPlan?['data']['seating_plan'][indexData]
                                    ['eligible'] ==
                                'YES') {
                              color = blue;
                            } else if (seatingPlan?['data']['seating_plan']
                                    [indexData]['eligible'] ==
                                'DEBARRED') {
                              color = red;
                            } else if (seatingPlan?['data']['seating_plan']
                                    [indexData]['eligible'] ==
                                'F_HOLD') {
                              color = yellow;
                            } else if (seatingPlan?['data']['seating_plan']
                                    [indexData]['eligible'] ==
                                'R_HOLD') {
                              color = magenta;
                            }
                            if (seatingPlan?['data']['seating_plan'][indexData]
                                    ['attendance'] ==
                                true) {
                              color = green;
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
                                child: Text(text,
                                    style: TextStyle(
                                        color: fontColor,
                                        fontSize: fontMedium)),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.width / 2,
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          childAspectRatio: 3,
                          crossAxisCount: 2,
                          padding: const EdgeInsets.all(8.0),
                          children: [
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: blue,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Flexible(
                                        child: Text('Seat Allocated')),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: gray,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Flexible(
                                        child: Text('Seat Unallocated')),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: green,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Flexible(
                                        child: Text('Student Present')),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: red,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Flexible(
                                        child: Flexible(
                                            child: Text('Seat Debarred'))),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: yellow,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Flexible(
                                        child: Text('Seat Financial Hold')),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 30,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: magenta,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    const Flexible(
                                        child: Text('Seat Registration Hold')),
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
    );
  }
}
