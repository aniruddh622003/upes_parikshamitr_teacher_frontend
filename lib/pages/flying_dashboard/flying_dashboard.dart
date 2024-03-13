// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/doubt_section/doubt_section.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/progress_bar.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/current_time.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class FlyingDashboard extends StatefulWidget {
  const FlyingDashboard({super.key});
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
  List roomNumbers = [3001, 3002, 3003, 3004, 3005];
  Map roomDetails = {
    "3001": ["Aarav Sharma", "Anil Sharma", "XYZ"],
    "3002": ["Aryan Sharma", "Eshan Dutta"],
    "3003": ["Aarav Sharma", "Anil Sharma"],
    "3004": ["Aarav Sharma", "Anil Sharma"],
    "3005": ["Aarav Sharma", "Anil Sharma"],
  };
  late Timer _timer;
  String formattedDate = DateFormat('EEEE, d MMMM, y').format(DateTime.now());

  // Future<Map> getDetails() async {
  //   final String? jwt = await const FlutterSecureStorage().read(key: 'jwt');
  //   var response = await http.get(
  //     Uri.parse('$serverUrl/teacher/getDetails'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $jwt',
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     data = jsonDecode(response.body)['data'];
  //     setState(() {});
  //   } else {
  //     data = {'name': 'Default'};
  //   }
  //   return {};
  // }

  @override
  void initState() {
    // getDetails();
    // getUnreadNotificationsCount();
    // _timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
    //   List notificationsLocal = [];
    //   dynamic response = await getNotifications();
    //   if (response.statusCode == 200) {
    //     List<dynamic> notificationsServer =
    //         jsonDecode(response.body)['data']['notifications'];
    //     String? notifcationsData =
    //         await const FlutterSecureStorage().read(key: 'notifications');
    //     if (notifcationsData != null) {
    //       notificationsLocal = jsonDecode(notifcationsData);
    //       // sync notificationsLocal with notificationsServer and update notificationsLocal
    //       List toAdd = [];
    //       bool newNotification = false;
    //       for (var notification in notificationsServer) {
    //         bool found = false;
    //         for (var localNotification in notificationsLocal) {
    //           if (notification['_id'] == localNotification[0]['_id']) {
    //             found = true;
    //             break;
    //           }
    //         }
    //         if (!found) {
    //           newNotification = true;
    //           List item = [];
    //           item.add(notification);
    //           item.add(false);
    //           toAdd.add(item);
    //         }
    //       }
    //       for (var item in toAdd) {
    //         notificationsLocal.add(item);
    //       }
    //       if (newNotification) {
    //         Fluttertoast.showToast(
    //             msg: "You have new notification(s).",
    //             toastLength: Toast.LENGTH_LONG,
    //             gravity: ToastGravity.BOTTOM,
    //             timeInSecForIosWeb: 3,
    //             backgroundColor: grayLight,
    //             textColor: black,
    //             fontSize: 16.0);
    //       }
    //       // Delete notifications from notificationsLocal that are not in notificationsServer
    //       List toRemove = [];

    //       for (var localNotification in notificationsLocal) {
    //         bool found = false;
    //         for (var notification in notificationsServer) {
    //           if (notification['_id'] == localNotification[0]['_id']) {
    //             found = true;
    //             break;
    //           }
    //         }
    //         if (!found) {
    //           toRemove.add(localNotification);
    //         }
    //       }

    //       for (var item in toRemove) {
    //         notificationsLocal.remove(item);
    //       }

    //       await const FlutterSecureStorage().write(
    //           key: 'notifications', value: jsonEncode(notificationsLocal));
    //     } else {
    //       for (var notification in notificationsServer) {
    //         List item = [];
    //         item.add(notification);
    //         item.add(false);
    //         notificationsLocal.add(item);
    //       }
    //       await const FlutterSecureStorage().write(
    //           key: 'notifications', value: jsonEncode(notificationsLocal));
    //     }
    //   }
    //   setState(() {
    //     getUnreadNotificationsCount();
    //   });
    // });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  // Future<void> getUnreadNotificationsCount() async {
  //   String? notifcationsData =
  //       await const FlutterSecureStorage().read(key: 'notifications');
  //   if (notifcationsData != null) {
  //     List<dynamic> notifications = jsonDecode(notifcationsData);
  //     int count = 0;
  //     for (var notification in notifications) {
  //       if (!notification[1]) {
  //         count++;
  //       }
  //     }
  //     unreadNotificationsCount = count;
  //   } else {
  //     unreadNotificationsCount = 0;
  //   }
  // }

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
              onPressed: () {
                setState(() {});
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
                    Container(
                      decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: null,
                        // isButtonEnabled
                        // ? () async {
                        //     setState(() {
                        //       isButtonEnabled = false;
                        //     });
                        //     List notificationsLocal = [];
                        //     List<dynamic> today = [];
                        //     List<dynamic> yesterday = [];
                        //     List<dynamic> earlier = [];
                        //     List<bool> todayBool = [];
                        //     List<bool> yesterdayBool = [];
                        //     List<bool> earlierBool = [];
                        //     dynamic response = await getNotifications();
                        //     if (response.statusCode == 200) {
                        //       List<dynamic> notificationsServer =
                        //           jsonDecode(response.body)['data']
                        //               ['notifications'];
                        //       String? notifcationsData =
                        //           await const FlutterSecureStorage()
                        //               .read(key: 'notifications');
                        //       if (notifcationsData != null) {
                        //         notificationsLocal =
                        //             jsonDecode(notifcationsData);
                        //         // sync notificationsLocal with notificationsServer and update notificationsLocal
                        //         for (var notification
                        //             in notificationsServer) {
                        //           bool found = false;
                        //           for (var localNotification
                        //               in notificationsLocal) {
                        //             if (notification['_id'] ==
                        //                 localNotification[0]['_id']) {
                        //               found = true;
                        //               break;
                        //             }
                        //           }
                        //           if (!found) {
                        //             List item = [];
                        //             item.add(notification);
                        //             item.add(false);
                        //             notificationsLocal.add(item);
                        //           }
                        //         }
                        //         // Delete notifications from notificationsLocal that are not in notificationsServer
                        //         for (var localNotification
                        //             in notificationsLocal) {
                        //           bool found = false;
                        //           for (var notification
                        //               in notificationsServer) {
                        //             if (notification['_id'] ==
                        //                 localNotification[0]['_id']) {
                        //               found = true;
                        //               break;
                        //             }
                        //           }
                        //           if (!found) {
                        //             notificationsLocal
                        //                 .remove(localNotification);
                        //           }
                        //         }
                        //         await const FlutterSecureStorage().write(
                        //             key: 'notifications',
                        //             value: jsonEncode(notificationsLocal));
                        //       } else {
                        //         for (var notification
                        //             in notificationsServer) {
                        //           List item = [];
                        //           item.add(notification);
                        //           item.add(false);
                        //           notificationsLocal.add(item);
                        //         }
                        //         await const FlutterSecureStorage().write(
                        //             key: 'notifications',
                        //             value: jsonEncode(notificationsLocal));
                        //       }
                        //       for (var notification in notificationsLocal) {
                        //         if (DateTime.parse(
                        //                     notification[0]['createdAt'])
                        //                 .difference(DateTime.now())
                        //                 .inDays ==
                        //             0) {
                        //           today.add(notification[0]);
                        //           todayBool.add(notification[1]);
                        //         } else if (DateTime.parse(
                        //                     notification[0]['createdAt'])
                        //                 .difference(DateTime.now())
                        //                 .inDays ==
                        //             -1) {
                        //           yesterday.add(notification[0]);
                        //           yesterdayBool.add(notification[1]);
                        //         } else {
                        //           earlier.add(notification[0]);
                        //           earlierBool.add(notification[1]);
                        //         }
                        //       }

                        //       setState(() {
                        //         getUnreadNotificationsCount();
                        //       });

                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (context) =>
                        //                 NotificationScreen(
                        //                     today: today,
                        //                     yesterday: yesterday,
                        //                     earlier: earlier,
                        //                     todayBool: todayBool,
                        //                     yesterdayBool: yesterdayBool,
                        //                     earlierBool: earlierBool)),
                        //       ).then((_) {
                        //         setState(() {
                        //           isButtonEnabled = true;
                        //           getUnreadNotificationsCount();
                        //         });
                        //       });
                        //     } else {
                        //       errorDialog(context,
                        //           'Error occurred! Please try again later');
                        //     }
                        //   }
                        // : null,
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
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: roomNumbers.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: selectedIndex == index ? orange : blue50,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  roomNumbers[index].toString(),
                                  textScaler: const TextScaler.linear(1),
                                  style: TextStyle(
                                    fontSize: fontMedium,
                                    color:
                                        selectedIndex == index ? white : orange,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: GestureDetector(
                              onTap: null,
                              // () => ufmPopup(context),
                              child:
                                  SvgPicture.asset('android/assets/ufm.svg')),
                        ),
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
                              onTap: null,
                              // () async {
                              //   dynamic responseSupp = await getSupplies();
                              //   List<dynamic> suppliesList =
                              //       jsonDecode(responseSupp.body)['data'];
                              //   for (Map item in suppliesList) {
                              //     if (item['quantity'] != 0) {
                              //       errorDialog(context,
                              //           "Please clear all the pending supplies");
                              //       return;
                              //     }
                              //   }
                              //   const storage = FlutterSecureStorage();
                              //   final String? roomId =
                              //       await storage.read(key: 'roomId');
                              //   dynamic response =
                              //       await checkRoomStatus(roomId.toString());
                              //   if (response.statusCode == 200) {
                              //     if (jsonDecode(response.body)['data'] ==
                              //         "COMPLETED") {
                              //       Fluttertoast.showToast(
                              //           msg:
                              //               "Invigilation Completed Successfully!",
                              //           toastLength: Toast.LENGTH_LONG,
                              //           gravity: ToastGravity.BOTTOM,
                              //           timeInSecForIosWeb: 3,
                              //           backgroundColor: Colors.grey,
                              //           textColor: Colors.white,
                              //           fontSize: 16.0);
                              //       const FlutterSecureStorage()
                              //           .delete(key: 'roomId');
                              //       String? jwt =
                              //           await const FlutterSecureStorage()
                              //               .read(key: 'jwt');
                              //       Navigator.pop(context);
                              //       Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //           builder: (context) =>
                              //               Dashboard(jwt: jwt),
                              //         ),
                              //       );
                              //       return;
                              //     }
                              //   }
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) =>
                              //               const SubmitToController()));
                              // },
                              child: SvgPicture.asset(
                                  'android/assets/controller.svg')),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Invigilators',
                                textScaler: TextScaler.linear(1),
                                style: TextStyle(
                                  fontSize: fontMedium,
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: roomDetails[
                                        roomNumbers[selectedIndex].toString()]
                                    .length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text(roomDetails[
                                            roomNumbers[selectedIndex]
                                                .toString()][index]
                                        .toString()),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
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
