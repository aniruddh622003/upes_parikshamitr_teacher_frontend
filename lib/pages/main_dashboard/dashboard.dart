// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/assign_invigilator.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_notifications.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/flying_dashboard/flying_dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/invigilator_dashboard.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/submission_page.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login/home_activity.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/notification_screen.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/phone_email_input.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/schedule.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/start_invigilation/start_invigilation.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  final String? jwt;

  const Dashboard({super.key, required this.jwt});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Map data;
  late Timer _timer;
  int unreadNotificationsCount = 0;
  bool isPageLoaded = false;
  bool isButtonEnabled = true;

  String formattedDate = DateFormat('EEEE, d MMMM, y').format(DateTime.now());

  Future<Map> getDetails({token}) async {
    var response = await http.get(
      Uri.parse('$serverUrl/teacher/getDetails'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      data = jsonDecode(response.body)['data'];
      int? phone = data['phone'];
      String? email = data['email'];
      if (phone == null || email == null) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CheckPhoneEmail()),
        );
      }
    } else {
      errorDialog(context, 'Error occurred! Please try again later');
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeActivity()),
      );
    }
    return {};
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

  void checkInvigilationState() async {
    const storage = FlutterSecureStorage();
    String? roomId = await storage.read(key: 'roomId');
    String? slotId = await storage.read(key: 'slotId');
    String? submissionState = await storage.read(key: 'submission_state');
    if (slotId != null) {
      String? uniqueCode = await storage.read(key: 'unique_code');
      Map data = {
        'unique_code': uniqueCode.toString(),
        // Add other data if needed
      };
      var response = await assignInvigilator(data);
      Map roomData = jsonDecode(response.body)['data'];
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FlyingDashboard(roomData: roomData["room_data"]),
          ));
    } else if (roomId != null) {
      if (submissionState != null) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SubmissionDetails()),
        );
      } else {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const InvigilatorDashboard()),
        );
      }
    }
  }

  void checkPhoneEmail() async {}

  @override
  void initState() {
    checkInvigilationState();
    getDetails(token: widget.jwt);
    getUnreadNotificationsCount();
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
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
                backgroundColor: grayLight,
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

  final storage = const FlutterSecureStorage();

  void signOut() async {
    late bool confirm = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Confirm Sign Out',
          textScaler: TextScaler.linear(1),
        ),
        content: const Text(
          'Are you sure you want to sign out?',
          textScaler: TextScaler.linear(1),
        ),
        actions: [
          TextButton(
            child: const Text(
              'Cancel',
              textScaler: TextScaler.linear(1),
            ),
            onPressed: () {
              confirm = false;
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'Sign Out',
              textScaler: TextScaler.linear(1),
            ),
            onPressed: () async {
              confirm = true;
              await storage.delete(key: 'notifications');
              await storage.delete(key: 'roomId');
              await storage.delete(key: 'unique_code');
              await storage.delete(key: 'jwt');
              await storage.delete(key: 'submission_state');
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );

    if (confirm) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeActivity()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getDetails(token: widget.jwt),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !isPageLoaded) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(
              body: Center(
                  child: Text(
            'Error: ${snapshot.error}',
            textScaler: const TextScaler.linear(1),
          )));
        } else {
          isPageLoaded = true;
          return Scaffold(
              backgroundColor: blue,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: white),
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.logout, color: white),
                          onPressed: () {
                            signOut();
                          },
                        ),
                        const Text(
                          'Dashboard',
                          textScaler: TextScaler.linear(1),
                          style: TextStyle(color: white),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.qr_code, color: white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StartInvigilation()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      formattedDate,
                      textScaler: const TextScaler.linear(1),
                      style: const TextStyle(color: white, fontSize: fontSmall),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      'Hi, ${data['name']}!',
                      textScaler: const TextScaler.linear(1),
                      style: const TextStyle(color: white, fontSize: fontLarge),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                        child: ListView(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ElevatedButton(
                                onPressed: isButtonEnabled
                                    ? () async {
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
                            const Schedule(),
                            const SizedBox(height: 10),
                          ],
                        )),
                  ),
                ],
              ));
        }
      },
    );
  }
}
