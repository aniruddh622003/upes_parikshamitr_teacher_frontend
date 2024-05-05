// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/check_room_status.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_flying_data.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_invigilators.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_notifications.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_room_details.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_supplies.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/doubt_section/doubt_section.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/flying_dashboard/details_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/add_pending_supplies_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/bsheet_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/exam_sumary.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/flying_visit_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/pending_supplies_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/progress_bar.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/seating_arrangement.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/submit_to_controller.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/ufm_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/notification_screen.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/current_time.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:async';

class InvigilatorDashboard extends StatefulWidget {
  const InvigilatorDashboard({super.key});
  @override
  State<InvigilatorDashboard> createState() => _InvigilatorDashboardState();
}

class _InvigilatorDashboardState extends State<InvigilatorDashboard> {
  String? roomNo = "";
  Map data = {};
  bool isPageLoaded = false;
  bool isButtonEnabled = true;
  bool isExamSummaryEnabled = true;
  int unreadNotificationsCount = 0;
  late Timer _timer;
  String formattedDate = DateFormat('EEEE, d MMMM, y').format(DateTime.now());
  Future<Map> getDetails() async {
    final String? jwt = await const FlutterSecureStorage().read(key: 'jwt');
    roomNo = await const FlutterSecureStorage().read(key: 'room_no');
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

  @override
  void initState() {
    getDetails();
    getUnreadNotificationsCount();
    _timer = Timer.periodic(Duration(seconds: timerDuration), (timer) async {
      setState(() {});
      List notificationsLocal = [];
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

  Future<Widget> makeFlyingPanel() async {
    List<Widget> items = [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Flying Squad',
              textScaler: TextScaler.linear(1),
              style: TextStyle(color: white),
            ),
          ],
        ),
      ),
    ];
    dynamic response = await getFlyingData();
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['flying_squad'];
      for (Map flying in data) {
        Color buttonColor = Colors.transparent;
        Color textColor = orange;
        String text = "";
        if (flying['status'] == "assigned") {
          text = "Not Visited";
          buttonColor = Colors.transparent;
          textColor = orange;
        } else if (flying['status'] == "requested") {
          text = "Requested";
          buttonColor = orange;
          textColor = white;
        } else if (flying['status'] == "approved") {
          text = "Visited";
          buttonColor = green;
          textColor = white;
        }

        items.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(
                color: gray,
              ),
            ),
            color: grayLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => detailsPopup(context, flying['teacher']),
                child: Text(
                  flying['teacher']['name'],
                  textScaler: const TextScaler.linear(1),
                  style: const TextStyle(
                    fontSize: fontSmall,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
                width: 150,
                child: ElevatedButton(
                  onPressed: flying['status'] == "requested"
                      ? () async {
                          try {
                            flyingVisitPopup(context, flying).then((value) {
                              setState(() {});
                            });
                          } catch (e) {
                            errorDialog(context, e.toString());
                          }
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return buttonColor;
                    }),
                    foregroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      return textColor;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Change this to your desired border radius
                      ),
                    ),
                  ),
                  child: Text(
                    text.toString(),
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                      fontSize: fontSmall,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
      }
    }
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: grayLight,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items,
      ),
    );
  }

  Future<Widget> makePendingItems() async {
    // const storage = FlutterSecureStorage();
    // String? pendingSupplies = await storage.read(key: 'pendingSupplies');
    dynamic response = await getSupplies();
    List<Widget> items = [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pending Supplies',
              textScaler: TextScaler.linear(1),
              style: TextStyle(color: white),
            ),
            InkWell(
              onTap: () {
                // Handle the icon tap here
                addPendingSuppliesPopup(context);
              },
              child: const Icon(
                Icons.add_circle_outline,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ];
    if (jsonDecode(response.body)['data'].runtimeType != Null) {
      List<dynamic> suppliesList = jsonDecode(response.body)['data'];
      if (suppliesList.isEmpty) {
        items.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(
                color: gray,
              ),
            ),
            color: grayLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Text(
                  'No pending supplies',
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                    fontSize: fontSmall,
                  ),
                ),
              ),
            ],
          ),
        ));
      } else {
        for (Map item in suppliesList) {
          if (item['quantity'] == 0) {
            continue;
          } else {
            items.add(Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: const Border(
                  bottom: BorderSide(
                    color: gray,
                  ),
                ),
                color: grayLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      item['type'],
                      textScaler: const TextScaler.linear(1),
                      style: const TextStyle(
                        fontSize: fontSmall,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: item['quantity'] > 0
                          ? () {
                              try {
                                pendingSuppliesPopup(
                                    context, item, suppliesList);
                              } catch (e) {
                                errorDialog(context, e.toString());
                              }
                            }
                          : null,
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors
                                  .transparent; // Use the same background color when the button is disabled
                            }
                            return item['quantity'] > 0
                                ? Colors.orange
                                : Colors.transparent;
                          },
                        ),
                        foregroundColor:
                            MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors
                                  .green; // Use the same text color when the button is disabled
                            }
                            return Colors.white;
                          },
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10.0), // Change this to your desired border radius
                          ),
                        ),
                      ),
                      child: Text(
                        "Pending: ${item['quantity']}",
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(
                          fontSize: fontSmall,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ));
          }
        }
      }

      if (items.length == 1) {
        items.add(Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(
                color: gray,
              ),
            ),
            color: grayLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Text(
                  'No pending supplies',
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(
                    fontSize: fontSmall,
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    } else {
      items.add(Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: const Border(
            bottom: BorderSide(
              color: gray,
            ),
          ),
          color: grayLight,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Expanded(
              child: Text(
                'No pending supplies',
                textScaler: TextScaler.linear(1),
                style: TextStyle(
                  fontSize: fontSmall,
                ),
              ),
            ),
          ],
        ),
      ));
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: grayLight,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: const Text(
            'Invigilation Dashboard',
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
              onPressed: () {
                try {
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
                style: const TextStyle(color: white, fontSize: fontLarge)),
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
                        style:
                            const TextStyle(color: white, fontSize: fontMedium),
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Room No.",
                              textScaler: TextScaler.linear(1),
                              style: TextStyle(
                                  fontSize: fontMedium,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: 75,
                              height: 35,
                              decoration: const BoxDecoration(
                                color: blue,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Center(
                                child: Text(
                                  roomNo.toString(),
                                  textScaler: const TextScaler.linear(1),
                                  style: const TextStyle(
                                    color: white,
                                    fontSize: fontSmall,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                                  Loader.show(context,
                                      // isAppbarOverlay: true,
                                      // isBottomBarOverlay: true,
                                      progressIndicator:
                                          const CircularProgressIndicator());
                                  List notificationsLocal = [];
                                  List<dynamic> today = [];
                                  List<dynamic> yesterday = [];
                                  List<dynamic> earlier = [];
                                  List<bool> todayBool = [];
                                  List<bool> yesterdayBool = [];
                                  List<bool> earlierBool = [];
                                  dynamic response = await getNotifications();
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
                                              localNotification[0]['_id']) {
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
                                              localNotification[0]['_id']) {
                                            found = true;
                                            break;
                                          }
                                        }
                                        if (!found) {
                                          notificationsLocal
                                              .remove(localNotification);
                                        }
                                      }
                                      await const FlutterSecureStorage().write(
                                          key: 'notifications',
                                          value:
                                              jsonEncode(notificationsLocal));
                                    } else {
                                      for (var notification
                                          in notificationsServer) {
                                        List item = [];
                                        item.add(notification);
                                        item.add(false);
                                        notificationsLocal.add(item);
                                      }
                                      await const FlutterSecureStorage().write(
                                          key: 'notifications',
                                          value:
                                              jsonEncode(notificationsLocal));
                                    }
                                    for (var notification
                                        in notificationsLocal) {
                                      if (DateTime.parse(
                                                  notification[0]['createdAt'])
                                              .difference(DateTime.now())
                                              .inDays ==
                                          0) {
                                        today.add(notification[0]);
                                        todayBool.add(notification[1]);
                                      } else if (DateTime.parse(
                                                  notification[0]['createdAt'])
                                              .difference(DateTime.now())
                                              .inDays ==
                                          -1) {
                                        yesterday.add(notification[0]);
                                        yesterdayBool.add(notification[1]);
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
                                                  yesterdayBool: yesterdayBool,
                                                  earlierBool: earlierBool)),
                                    ).then((_) {
                                      setState(() {
                                        isButtonEnabled = true;
                                        getUnreadNotificationsCount();
                                      });
                                    });
                                    Loader.hide();
                                  } else {
                                    Loader.hide();
                                    errorDialog(context,
                                        'Error occurred! Please try again later');
                                  }
                                } catch (e) {
                                  errorDialog(context, e.toString());
                                } finally {
                                  Loader.hide();
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
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                              onTap: () => ufmPopup(context),
                              child:
                                  SvgPicture.asset('android/assets/ufm.svg')),
                        ),
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                bsheetPopup(context);
                              },
                              // bsheetPopup(context),
                              child: SvgPicture.asset(
                                  'android/assets/supplementary.svg')),
                        ),
                        Expanded(
                          child: GestureDetector(
                              onTap: isButtonEnabled
                                  ? () async {
                                      try {
                                        setState(() {
                                          isButtonEnabled = false;
                                        });
                                        Loader.show(context,
                                            progressIndicator:
                                                const CircularProgressIndicator());
                                        dynamic responseSupp =
                                            await getSupplies();
                                        List<dynamic> suppliesList = jsonDecode(
                                            responseSupp.body)['data'];
                                        for (Map item in suppliesList) {
                                          if (item['quantity'] != 0) {
                                            errorDialog(context,
                                                "Please clear all the pending supplies");
                                            return;
                                          }
                                        }
                                        const storage = FlutterSecureStorage();
                                        final String? roomId =
                                            await storage.read(key: 'roomId');
                                        dynamic response =
                                            await checkRoomStatus(
                                                roomId.toString());
                                        if (response.statusCode == 200) {
                                          if (jsonDecode(
                                                  response.body)['data'] ==
                                              "COMPLETED") {
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Invigilation Completed Successfully!",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 3,
                                                backgroundColor: white,
                                                textColor: black,
                                                fontSize: 16.0);

                                            const storage =
                                                FlutterSecureStorage();

                                            // Read and store 'jwt' and 'notifications'
                                            String? jwt =
                                                await storage.read(key: 'jwt');
                                            String? notifications =
                                                await storage.read(
                                                    key: 'notifications');

                                            // Delete all data
                                            await storage.deleteAll();

                                            // Write back 'jwt' and 'notifications' if they were not null
                                            if (jwt != null) {
                                              await storage.write(
                                                  key: 'jwt', value: jwt);
                                            }
                                            if (notifications != null) {
                                              await storage.write(
                                                  key: 'notifications',
                                                  value: notifications);
                                            }
                                            Navigator.pop(context);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Dashboard(jwt: jwt),
                                              ),
                                            );
                                            Loader.hide();
                                            return;
                                          }
                                        }
                                        Loader.hide();
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SubmitToController()))
                                            .then((value) => setState(() {
                                                  isButtonEnabled = true;
                                                }));
                                      } catch (e) {
                                        errorDialog(context, e.toString());
                                      } finally {
                                        Loader.hide();
                                      }
                                    }
                                  : null,
                              // onDoubleTap: () {},

                              child: SvgPicture.asset(
                                  'android/assets/controller.svg')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: () =>
                              //     "This feature is currently under development."),
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DoubtSection())),
                          child: SvgPicture.asset('android/assets/doubt.svg'),
                        )),
                        Expanded(
                            child: GestureDetector(
                          onTap: () => attendancePopup(context),
                          child: SvgPicture.asset('android/assets/qr.svg'),
                        )),
                        Expanded(
                            child: GestureDetector(
                          onTap: () async {
                            try {
                              const storage = FlutterSecureStorage();
                              final String? roomId =
                                  await storage.read(key: 'roomId');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SeatingArrangement(
                                            roomId: roomId.toString(),
                                          )));
                            } catch (e) {
                              errorDialog(context, e.toString());
                            }
                          },
                          child: SvgPicture.asset(
                              'android/assets/seatingplan.svg'),
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: isExamSummaryEnabled
                              ? () async {
                                  try {
                                    setState(() {
                                      isExamSummaryEnabled = false;
                                    });
                                    Loader.show(context,
                                        isAppbarOverlay: true,
                                        isBottomBarOverlay: true,
                                        progressIndicator:
                                            const CircularProgressIndicator());
                                    String? roomId =
                                        await const FlutterSecureStorage()
                                            .read(key: 'roomId');
                                    dynamic response =
                                        await getRoomDetails(roomId.toString());
                                    if (response.statusCode == 200) {
                                      Map roomDetails =
                                          jsonDecode(response.body);
                                      dynamic responseInvigilators =
                                          await getInvigilators();
                                      if (responseInvigilators.statusCode ==
                                          200) {
                                        Map invigilators = jsonDecode(
                                            responseInvigilators.body);
                                        roomDetails['invigilators'] =
                                            invigilators['data'];
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ExamSummary(
                                                            roomDetails:
                                                                roomDetails)))
                                            .then((_) {
                                          setState(() {
                                            isExamSummaryEnabled = true;
                                          });
                                        });
                                      } else {
                                        errorDialog(context,
                                            "An error occurred while fetching invigilator details.");
                                        isExamSummaryEnabled = true;
                                      }
                                    } else {
                                      errorDialog(context,
                                          "An error occurred while fetching room details.");
                                      isExamSummaryEnabled = true;
                                    }
                                    Loader.hide();
                                  } catch (e) {
                                    errorDialog(context, e.toString());
                                  } finally {
                                    Loader.hide();
                                  }
                                }
                              : null,
                          child: SvgPicture.asset(
                              'android/assets/examsummary.svg'),
                        )),
                      ],
                    ),
                    // Container(
                    //   margin:
                    //       const EdgeInsets.only(right: 20, left: 20, top: 10),
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     color: grayLight,
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.stretch,
                    //     children: [
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 10, vertical: 10),
                    //         decoration: const BoxDecoration(
                    //           color: blue,
                    //           borderRadius: BorderRadius.only(
                    //               topLeft: Radius.circular(10),
                    //               topRight: Radius.circular(10)),
                    //         ),
                    //         child: const Row(
                    //           children: [
                    //             Text(
                    //               'Flying Squad',
                    //               textScaler: TextScaler.linear(1),
                    //               style: TextStyle(
                    //                 color: white,
                    //                 fontSize: fontSmall,
                    //                 fontWeight: FontWeight.normal,
                    //               ),
                    //             ),
                    //             // const Spacer(),
                    //             // Container(
                    //             //   padding: const EdgeInsets.only(right: 7),
                    //             //   child: SvgPicture.asset(
                    //             //       'android/assets/refresh.svg'),
                    //             // ),
                    //             // const Text(
                    //             //   "Refresh",
                    //             //   style: TextStyle(
                    //             //       fontSize: fontXSmall,
                    //             //       color: Colors.white),
                    //             // ),
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 10, vertical: 5),
                    //         decoration: BoxDecoration(
                    //           border: const Border(
                    //             bottom: BorderSide(
                    //               color: gray,
                    //             ),
                    //           ),
                    //           color: grayLight,
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: const Row(
                    //           children: [
                    //             Expanded(
                    //               child: Text(
                    //                 'Dr. Rajat Gupta',
                    //                 textScaler: TextScaler.linear(1),
                    //                 style: TextStyle(
                    //                   fontSize: fontSmall,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 10, vertical: 5),
                    //         decoration: BoxDecoration(
                    //           border: const Border(
                    //             bottom: BorderSide(
                    //               color: gray,
                    //             ),
                    //           ),
                    //           color: grayLight,
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: const Row(
                    //           children: [
                    //             Expanded(
                    //               child: Text(
                    //                 'Dr. Anil Kumar',
                    //                 textScaler: TextScaler.linear(1),
                    //                 style: TextStyle(
                    //                   fontSize: fontSmall,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             horizontal: 10, vertical: 5),
                    //         decoration: BoxDecoration(
                    //           border: const Border(
                    //             bottom: BorderSide(
                    //               color: gray,
                    //             ),
                    //           ),
                    //           color: grayLight,
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: const Row(
                    //           children: [
                    //             Expanded(
                    //               child: Text(
                    //                 'Dr. Atul Kumar',
                    //                 textScaler: TextScaler.linear(1),
                    //                 style: TextStyle(
                    //                   fontSize: fontSmall,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    FutureBuilder<Widget>(
                      future: makePendingItems(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if ((snapshot.connectionState ==
                                    ConnectionState.waiting &&
                                !isPageLoaded) ||
                            snapshot.data == null) {
                          isPageLoaded = true;
                          return const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ); // or some other widget while waiting
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            textScaler: const TextScaler.linear(1),
                          );
                        } else {
                          return snapshot.data!;
                        }
                      },
                    ),

                    FutureBuilder<Widget>(
                      future: makeFlyingPanel(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Widget> snapshot) {
                        if ((snapshot.connectionState ==
                                    ConnectionState.waiting &&
                                !isPageLoaded) ||
                            snapshot.data == null) {
                          isPageLoaded = true;
                          return const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ); // or some other widget while waiting
                        } else if (snapshot.hasError) {
                          return Text(
                            'Error: ${snapshot.error}',
                            textScaler: const TextScaler.linear(1),
                          );
                        } else {
                          return snapshot.data!;
                        }
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ));
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
