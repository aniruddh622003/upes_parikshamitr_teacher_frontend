// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_invigilator_data.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_notifications.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_rooms_assigned.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/doubt_section/doubt_section.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/flying_dashboard/details_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/flying_dashboard/final_remarks.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/flying_dashboard/room_remarks.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/progress_bar.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/seating_arrangement.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/ufm_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/notification_screen.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/current_time.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

// ignore: must_be_immutable
class FlyingDashboard extends StatefulWidget {
  List roomData;
  FlyingDashboard({super.key, required this.roomData});
  @override
  State<FlyingDashboard> createState() => _FlyingDashboardState();
}

class _FlyingDashboardState extends State<FlyingDashboard> {
  Map data = {};
  bool isPageLoaded = false;
  bool isButtonEnabled = true;
  bool isExamSummaryEnabled = true;
  int unreadNotificationsCount = 0;
  int selectedIndex = 0;
  Map currentRoomDetails = {};

  late Timer _timer;
  String formattedDate = DateFormat('EEEE, d MMMM, y').format(DateTime.now());

  Future<Map> getDetails() async {
    final String? jwt = await const FlutterSecureStorage().read(key: 'jwt');
    var response = await http.get(
      Uri.parse('$serverUrl/teacher/getDetails'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['data'];
      setState(() {});
    } else {
      data = {'name': 'Default'};
    }
    return {};
  }

  Future<dynamic> setCurrentRoomData(int index) async {
    try {
      if (widget.roomData.isEmpty) {
        return {};
      }
      dynamic response =
          await getInvigilatorData(widget.roomData[index]['room_id']);
      if (response.statusCode == 200) {
        return jsonDecode(response.body)['invigilators'];
      } else {
        errorDialog(
            context, 'An error occurred while fetching invigilator data.');
        return {};
      }
    } catch (e) {
      errorDialog(context, e.toString());
      return {};
    }
  }

  @override
  void initState() {
    getDetails();
    getUnreadNotificationsCount();
    _timer = Timer.periodic(Duration(seconds: timerDuration), (timer) async {
      List notificationsLocal = [];
      dynamic response2 = await getRoomsAssigned();
      if (response2.statusCode == 200) {
        widget.roomData = jsonDecode(response2.body)['rooms'];
        setState(() {});
      } else {
        errorDialog(context, 'An error occurred while fetching room data.');
      }
      dynamic response = await getNotifications();
      if (response.statusCode == 200) {
        List<dynamic> notificationsServer =
            jsonDecode(response.body)['data']['notifications'];
        String? notifcationsData =
            await const FlutterSecureStorage().read(key: 'notifications');
        if (notifcationsData != null) {
          notificationsLocal = jsonDecode(notifcationsData);
          // sync notificationsLocal with notificationsServer and update notificationsLocal
          List toAdd = [];
          bool newNotification = false;
          for (var notification in notificationsServer) {
            bool found = false;
            for (var localNotification in notificationsLocal) {
              if (notification['_id'] == localNotification[0]['_id']) {
                found = true;
                break;
              }
            }
            if (!found) {
              newNotification = true;
              List item = [];
              item.add(notification);
              item.add(false);
              toAdd.add(item);
            }
          }
          for (var item in toAdd) {
            notificationsLocal.add(item);
          }
          if (newNotification) {
            Fluttertoast.showToast(
                msg: "You have new notification(s).",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 3,
                backgroundColor: white,
                textColor: black,
                fontSize: 16.0);
          }
          // Delete notifications from notificationsLocal that are not in notificationsServer
          List toRemove = [];

          for (var localNotification in notificationsLocal) {
            bool found = false;
            for (var notification in notificationsServer) {
              if (notification['_id'] == localNotification[0]['_id']) {
                found = true;
                break;
              }
            }
            if (!found) {
              toRemove.add(localNotification);
            }
          }

          for (var item in toRemove) {
            notificationsLocal.remove(item);
          }

          await const FlutterSecureStorage().write(
              key: 'notifications', value: jsonEncode(notificationsLocal));
        } else {
          for (var notification in notificationsServer) {
            List item = [];
            item.add(notification);
            item.add(false);
            notificationsLocal.add(item);
          }
          await const FlutterSecureStorage().write(
              key: 'notifications', value: jsonEncode(notificationsLocal));
        }
      }
      setState(() {
        getUnreadNotificationsCount();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> getUnreadNotificationsCount() async {
    String? notifcationsData =
        await const FlutterSecureStorage().read(key: 'notifications');
    if (notifcationsData != null) {
      List<dynamic> notifications = jsonDecode(notifcationsData);
      int count = 0;
      for (var notification in notifications) {
        if (!notification[1]) {
          count++;
        }
      }
      unreadNotificationsCount = count;
    } else {
      unreadNotificationsCount = 0;
    }
  }

  Widget makeInvigilatorList() {
    if (widget.roomData.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 45 +
              (40.0 * currentRoomDetails.values.where((_) => _ != null).length),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: blue,
                height: 45, // Set the color to blue
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Invigilators',
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        fontSize: fontMedium,
                        color: Colors.white, // Set the text color to white
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Room: ${widget.roomData[selectedIndex]['room_no']}',
                      textScaler: const TextScaler.linear(1),
                      style: const TextStyle(
                        fontSize: fontMedium,
                        color: Colors.white, // Set the text color to white
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: currentRoomDetails.length,
                  itemBuilder: (context, index) {
                    String? currentKey =
                        currentRoomDetails.keys.toList()[index];
                    return currentRoomDetails[currentKey] == null
                        ? null
                        : GestureDetector(
                            onTap: () {
                              detailsPopup(
                                  context, currentRoomDetails[currentKey]);
                            },
                            child: Container(
                                decoration: const BoxDecoration(
                                  color:
                                      grayLight, // Set the background color to light gray
                                  border: Border(
                                    bottom: BorderSide(
                                        color:
                                            Colors.grey), // Add a bottom border
                                  ),
                                ),
                                alignment: Alignment.centerLeft,
                                height: 40,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal:
                                        10), // Reduce the horizontal padding
                                child:
                                    Text(currentRoomDetails[currentKey]['name'],
                                        textScaler: const TextScaler.linear(1),
                                        style: const TextStyle(
                                          fontSize: fontMedium - 2,
                                        ))),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: setCurrentRoomData(selectedIndex),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !isPageLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          ); // Show a loading spinner while waiting
        } else if (snapshot.hasError) {
          return Text(
            'Error: ${snapshot.error}',
            textScaler: const TextScaler.linear(1),
          ); // Show error message if something went wrong
        } else {
          isPageLoaded = true;
          currentRoomDetails = snapshot.data;
          return Scaffold(
              backgroundColor: primaryColor,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                title: const Text(
                  'Flying Squad Dashboard',
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                    fontSize: fontMedium,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
                backgroundColor: blue,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.refresh,
                      color: white,
                    ),
                    onPressed: () async {
                      try {
                        dynamic response = await getRoomsAssigned();
                        if (response.statusCode == 200) {
                          widget.roomData = jsonDecode(response.body)['rooms'];
                        } else {
                          errorDialog(context,
                              'An error occurred while fetching room data.');
                        }
                        setState(() {});
                      } catch (e) {
                        errorDialog(context, e.toString());
                      }
                    },
                  ),
                ],
              ),
              body: Column(
                children: [
                  Text(data['name'] ?? 'Default',
                      textScaler: const TextScaler.linear(1),
                      style:
                          const TextStyle(color: white, fontSize: fontLarge)),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          children: [
                            Text(
                              formattedDate,
                              textScaler: const TextScaler.linear(1),
                              style: const TextStyle(
                                  color: white, fontSize: fontMedium),
                            ),
                            const CurrentTimeWidget(),
                            // getPhaseText(),
                          ],
                        ),
                      )),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 14),
                    child: InvigilatorProgress(),
                  ),
                  Expanded(
                    child: Container(
                      // width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ElevatedButton(
                              onPressed: isButtonEnabled
                                  ? () async {
                                      try {
                                        setState(() {
                                          isButtonEnabled = false;
                                        });
                                        List notificationsLocal = [];
                                        List<dynamic> today = [];
                                        List<dynamic> yesterday = [];
                                        List<dynamic> earlier = [];
                                        List<bool> todayBool = [];
                                        List<bool> yesterdayBool = [];
                                        List<bool> earlierBool = [];
                                        dynamic response =
                                            await getNotifications();
                                        if (response.statusCode == 200) {
                                          List<dynamic> notificationsServer =
                                              jsonDecode(response.body)['data']
                                                  ['notifications'];
                                          String? notifcationsData =
                                              await const FlutterSecureStorage()
                                                  .read(key: 'notifications');
                                          if (notifcationsData != null) {
                                            notificationsLocal =
                                                jsonDecode(notifcationsData);
                                            // sync notificationsLocal with notificationsServer and update notificationsLocal
                                            for (var notification
                                                in notificationsServer) {
                                              bool found = false;
                                              for (var localNotification
                                                  in notificationsLocal) {
                                                if (notification['_id'] ==
                                                    localNotification[0]
                                                        ['_id']) {
                                                  found = true;
                                                  break;
                                                }
                                              }
                                              if (!found) {
                                                List item = [];
                                                item.add(notification);
                                                item.add(false);
                                                notificationsLocal.add(item);
                                              }
                                            }
                                            // Delete notifications from notificationsLocal that are not in notificationsServer
                                            for (var localNotification
                                                in notificationsLocal) {
                                              bool found = false;
                                              for (var notification
                                                  in notificationsServer) {
                                                if (notification['_id'] ==
                                                    localNotification[0]
                                                        ['_id']) {
                                                  found = true;
                                                  break;
                                                }
                                              }
                                              if (!found) {
                                                notificationsLocal
                                                    .remove(localNotification);
                                              }
                                            }
                                            await const FlutterSecureStorage()
                                                .write(
                                                    key: 'notifications',
                                                    value: jsonEncode(
                                                        notificationsLocal));
                                          } else {
                                            for (var notification
                                                in notificationsServer) {
                                              List item = [];
                                              item.add(notification);
                                              item.add(false);
                                              notificationsLocal.add(item);
                                            }
                                            await const FlutterSecureStorage()
                                                .write(
                                                    key: 'notifications',
                                                    value: jsonEncode(
                                                        notificationsLocal));
                                          }
                                          for (var notification
                                              in notificationsLocal) {
                                            if (DateTime.parse(notification[0]
                                                        ['createdAt'])
                                                    .difference(DateTime.now())
                                                    .inDays ==
                                                0) {
                                              today.add(notification[0]);
                                              todayBool.add(notification[1]);
                                            } else if (DateTime.parse(
                                                        notification[0]
                                                            ['createdAt'])
                                                    .difference(DateTime.now())
                                                    .inDays ==
                                                -1) {
                                              yesterday.add(notification[0]);
                                              yesterdayBool
                                                  .add(notification[1]);
                                            } else {
                                              earlier.add(notification[0]);
                                              earlierBool.add(notification[1]);
                                            }
                                          }

                                          setState(() {
                                            getUnreadNotificationsCount();
                                          });

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    NotificationScreen(
                                                        today: today,
                                                        yesterday: yesterday,
                                                        earlier: earlier,
                                                        todayBool: todayBool,
                                                        yesterdayBool:
                                                            yesterdayBool,
                                                        earlierBool:
                                                            earlierBool)),
                                          ).then((_) {
                                            setState(() {
                                              isButtonEnabled = true;
                                              getUnreadNotificationsCount();
                                            });
                                          });
                                        } else {
                                          errorDialog(context,
                                              'Error occurred! Please try again later');
                                        }
                                      } catch (e) {
                                        errorDialog(context, e.toString());
                                      }
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: const EdgeInsets.all(0)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'View Notification',
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(color: white),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: unreadNotificationsCount > 0
                                          ? orange
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      "${unreadNotificationsCount > 0 ? unreadNotificationsCount : ''}",
                                      textScaler: const TextScaler.linear(1),
                                      style: const TextStyle(color: white),
                                    ),
                                  ),
                                  const Spacer(),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Rooms to visit",
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontMedium), // Make the text bold
                              ),
                              // SizedBox(height: 10), // Give some gap
                              widget.roomData.isEmpty
                                  ? const Text(
                                      "No room(s) allocated.",
                                      textScaler: TextScaler.linear(1),
                                      style: TextStyle(
                                        fontSize: fontMedium,
                                      ),
                                    )
                                  : SizedBox(
                                      height: 50,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: widget.roomData.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedIndex = index;
                                              });
                                            },
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              decoration: BoxDecoration(
                                                color: selectedIndex == index
                                                    ? orange
                                                    : widget.roomData[index]
                                                                ['status'] ==
                                                            'requested'
                                                        ? yellow
                                                        : widget.roomData[index]
                                                                    [
                                                                    'status'] ==
                                                                'approved'
                                                            ? green
                                                            : blue50,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  widget.roomData[index]
                                                          ["room_no"]
                                                      .toString(),
                                                  textScaler:
                                                      const TextScaler.linear(
                                                          1),
                                                  style: TextStyle(
                                                    fontSize: fontMedium,
                                                    color: selectedIndex ==
                                                            index
                                                        ? white
                                                        : (widget.roomData[index]
                                                                        [
                                                                        'status'] ==
                                                                    'requested' ||
                                                                widget.roomData[
                                                                            index]
                                                                        [
                                                                        'status'] ==
                                                                    'approved')
                                                            ? white
                                                            : orange,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GestureDetector(
                                    onTap: widget.roomData.isEmpty
                                        ? null
                                        : () async {
                                            await const FlutterSecureStorage()
                                                .delete(key: 'roomId');
                                            await const FlutterSecureStorage()
                                                .write(
                                                    key: 'roomId',
                                                    value: widget
                                                        .roomData[selectedIndex]
                                                            ['room_id']
                                                        .toString());
                                            ufmPopup(context);
                                          },
                                    child: SvgPicture.asset(
                                        'android/assets/ufm.svg')),
                              ),
                              Expanded(
                                  child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const DoubtSection())),
                                child: SvgPicture.asset(
                                    'android/assets/doubt.svg'),
                              )),
                              Expanded(
                                child: GestureDetector(
                                    onTap: () async {
                                      try {
                                        for (var item in widget.roomData) {
                                          if (item['status'] != 'approved') {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Please approve all rooms before proceeding.",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 3,
                                                backgroundColor: white,
                                                textColor: black,
                                                fontSize: 16.0);
                                            return;
                                          }
                                        }
                                        finalRemarks(context);
                                      } catch (e) {
                                        errorDialog(context, e.toString());
                                      }
                                    },
                                    child: SvgPicture.asset(
                                        'android/assets/leaveduty.svg')),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                onTap: () async {
                                  try {
                                    if (widget.roomData.isNotEmpty) {
                                      await const FlutterSecureStorage()
                                          .delete(key: 'roomId');
                                      await const FlutterSecureStorage().write(
                                          key: 'roomId',
                                          value: widget.roomData[selectedIndex]
                                                  ['room_id']
                                              .toString());
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SeatingArrangement(
                                                    roomId: widget
                                                        .roomData[selectedIndex]
                                                            ['room_id']
                                                        .toString(),
                                                  )));
                                    }
                                  } catch (e) {
                                    errorDialog(context, e.toString());
                                  }
                                },
                                child: SvgPicture.asset(
                                    'android/assets/seatingplan.svg'),
                              )),
                            ],
                          ),
                          const SizedBox(height: 10),
                          makeInvigilatorList(),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                foregroundColor: white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: widget.roomData.isNotEmpty &&
                                      widget.roomData[selectedIndex]
                                              ['status'] ==
                                          'assigned'
                                  ? () async {
                                      try {
                                        roomRemarks(
                                            context,
                                            widget.roomData[selectedIndex]
                                                ['room_id']);
                                      } catch (e) {
                                        errorDialog(context, e.toString());
                                      }
                                    }
                                  : null,
                              child: const Text('Room Remarks',
                                  textScaler: TextScaler.linear(1),
                                  style: TextStyle(fontSize: fontSmall)),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        }
      },
    );
  }

  Widget getPhaseText() {
    DateTime currentTime = DateTime.now();
    int currentHour = currentTime.hour;
    // String period = currentHour >= 12 ? 'PM' : 'AM';

    if (currentHour >= 0 && currentHour < 13) {
      return const Text(
        '(Phase I)',
        textScaler: TextScaler.linear(1),
        style: TextStyle(
          fontSize: fontMedium,
          color: white,
          fontWeight: FontWeight.normal,
        ),
      );
    } else {
      return const Text(
        '(Phase II)',
        textScaler: TextScaler.linear(1),
        style: TextStyle(
          fontSize: fontMedium,
          color: white,
          fontWeight: FontWeight.normal,
        ),
      );
    }
  }
}
