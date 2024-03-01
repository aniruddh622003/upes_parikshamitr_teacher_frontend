// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_notifications.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/config.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login/home_activity.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/notification_screen.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/main_dashboard/schedule.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/start_invigilation/start_invigilation.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class Dashboard extends StatefulWidget {
  final String? jwt;
  int unreadNotificationsCount = 0;
  Dashboard({super.key, required this.jwt});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Map data;
  late Timer _timer;

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
      widget.unreadNotificationsCount = count;
    } else {
      widget.unreadNotificationsCount = 0;
    }
  }

  @override
  void initState() {
    getDetails(token: widget.jwt);
    getUnreadNotificationsCount();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
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
              notificationsLocal.add(item);
            }
          }
          if (newNotification) {
            Fluttertoast.showToast(
                msg: "You have new notification(s).",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: grayLight,
                textColor: black,
                fontSize: 16.0);
          }
          // Delete notifications from notificationsLocal that are not in notificationsServer
          for (var localNotification in notificationsLocal) {
            bool found = false;
            for (var notification in notificationsServer) {
              if (notification['_id'] == localNotification[0]['_id']) {
                found = true;
                break;
              }
            }
            if (!found) {
              notificationsLocal.remove(localNotification);
            }
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
    });
    super.initState();
  }

  final storage = const FlutterSecureStorage();

  void signOut() async {
    late bool confirm = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(textScaler: TextScaler.linear(1), 'Confirm Sign Out'),
        content: const Text(
            textScaler: TextScaler.linear(1),
            'Are you sure you want to sign out?'),
        actions: [
          TextButton(
            child: const Text(textScaler: TextScaler.linear(1), 'Cancel'),
            onPressed: () {
              confirm = false;
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(textScaler: TextScaler.linear(1), 'Sign Out'),
            onPressed: () {
              confirm = true;
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );

    if (confirm) {
      await storage.delete(key: 'jwt');
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          return Scaffold(
              body: Center(
                  child: Text(
                      textScaler: const TextScaler.linear(1),
                      'Error: ${snapshot.error}')));
        } else {
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
                          textScaler: TextScaler.linear(1),
                          'Dashboard',
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
                      textScaler: const TextScaler.linear(1),
                      formattedDate,
                      style: const TextStyle(color: white, fontSize: fontSmall),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      textScaler: const TextScaler.linear(1),
                      'Hi, ${data['name']}!',
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
                                onPressed: () async {
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
                                    );
                                  } else {
                                    errorDialog(context,
                                        'Error occurred! Please try again later');
                                  }
                                },
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
                                        textScaler: TextScaler.linear(1),
                                        'View Notification',
                                        style: TextStyle(color: white),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color:
                                            widget.unreadNotificationsCount > 0
                                                ? orange
                                                : Colors.transparent,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        textScaler: const TextScaler.linear(1),
                                        "${widget.unreadNotificationsCount > 0 ? widget.unreadNotificationsCount : ''}",
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
