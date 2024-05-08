// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:intl/intl.dart' as intl;

class NotificationScreen extends StatefulWidget {
  final List<dynamic> today;
  final List<dynamic> yesterday;
  final List<dynamic> earlier;
  final List<bool> todayBool;
  final List<bool> yesterdayBool;
  final List<bool> earlierBool;
  const NotificationScreen(
      {super.key,
      required this.today,
      required this.yesterday,
      required this.earlier,
      required this.todayBool,
      required this.yesterdayBool,
      required this.earlierBool});

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: primaryColor,
          title: const Text(
            "Notification",
            textScaler: TextScaler.linear(1),
            style: TextStyle(
              fontSize: fontMedium,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              try {
                Navigator.of(context).pop();
              } catch (e) {
                errorDialog(context, e.toString());
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      widget.todayBool.isNotEmpty
                          ? NotificationCategoryBox(
                              title: "Today",
                              notifications: widget.today,
                              read: widget.todayBool,
                            )
                          : const SizedBox(),
                      // const SizedBox(height: 10),
                      widget.yesterdayBool.isNotEmpty
                          ? NotificationCategoryBox(
                              title: "Yesterday",
                              notifications: widget.yesterday,
                              read: widget.yesterdayBool,
                            )
                          : const SizedBox(),
                      // const SizedBox(height: 10),
                      widget.earlierBool.isNotEmpty
                          ? NotificationCategoryBox(
                              title: "Earlier",
                              notifications: widget.earlier,
                              read: widget.earlierBool,
                              showDate: true,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class NotificationCategoryBox extends StatelessWidget {
  final String title;
  final List<dynamic> notifications;
  final List<bool> read;
  final bool showDate;

  const NotificationCategoryBox({
    super.key,
    required this.title,
    required this.notifications,
    required this.read,
    this.showDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textScaler: const TextScaler.linear(1),
          style: const TextStyle(
            fontSize: fontSmall,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),
        ...List.generate(
          notifications.length,
          (index) => NotificationBox(
            id: notifications[index]['_id'].toString(),
            name: notifications[index]['sender'].toString(),
            subject: notifications[index]['title'].toString(),
            msg: notifications[index]['message'].toString(),
            isRead: read[index],
            dateTime: notifications[index]['createdAt'].toString(),
            showDate: showDate,
            onTap: () {},
          ),
        ).expand((widget) => [widget, const SizedBox(height: 10)]),
      ],
    );
  }
}

class NotificationBox extends StatefulWidget {
  final String id;
  final String name;
  final String subject;
  final String msg;
  final bool isRead;
  final String dateTime;
  final Function onTap;
  final bool showDate;

  const NotificationBox({
    super.key,
    required this.id,
    required this.name,
    required this.subject,
    required this.msg,
    required this.isRead,
    required this.dateTime,
    required this.onTap,
    required this.showDate,
  });

  @override
  _NotificationBoxState createState() => _NotificationBoxState();
}

class _NotificationBoxState extends State<NotificationBox> {
  bool isRead = false;
  String formattedTime = '';
  String formattedDate = '';
  @override
  void initState() {
    super.initState();
    isRead = widget.isRead;
    DateTime dateTime = DateTime.parse(widget.dateTime);
    dateTime = dateTime.add(const Duration(hours: 5, minutes: 30));
    formattedTime = intl.DateFormat.jm().format(dateTime);
    formattedDate = intl.DateFormat.yMMMMd().format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!isRead) {
          widget.onTap();
          String? notifcationsData =
              await const FlutterSecureStorage().read(key: 'notifications');
          List<dynamic> notifications = jsonDecode(notifcationsData!);
          for (int i = 0; i < notifications.length; i++) {
            if (notifications[i][0]['_id'] == widget.id) {
              notifications[i][1] = true;
              break;
            }
          }
          await const FlutterSecureStorage()
              .write(key: 'notifications', value: jsonEncode(notifications));
          setState(() {
            isRead = true;
          });
        }
        _showNotificationDetails(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isRead ? const Color(0xFF4A67D4) : const Color(0xFF6E83DB),
          border: isRead
              ? Border.all(
                  color: const Color(0xFF4A67D4),
                  width: 1,
                )
              : Border.all(
                  color: const Color(0xFFBDBDBD),
                  width: 1,
                ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: isRead
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 5,
                    offset: const Offset(0, 0),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                int maxLines = 1;

                TextPainter textPainter = TextPainter(
                  text: TextSpan(
                    text: widget.msg + widget.dateTime,
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  maxLines: maxLines,
                  textDirection: TextDirection.ltr,
                )..layout(maxWidth: constraints.maxWidth);

                if (textPainter.didExceedMaxLines) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.subject,
                        textScaler: const TextScaler.linear(1),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          // text color white when isRead is false, else black
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        widget.showDate ? formattedDate : formattedTime,
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.subject,
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        widget.showDate ? formattedDate : formattedTime,
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showNotificationDetails(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.subject,
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    widget.name,
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$formattedDate $formattedTime",
                    textScaler: const TextScaler.linear(1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 500),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.msg,
                        textScaler: const TextScaler.linear(1),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
