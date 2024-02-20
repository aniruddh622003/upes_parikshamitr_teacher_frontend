// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

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
              Navigator.of(context).pop();
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
                      NotificationCategoryBox(
                        title: "Today",
                        notifications: widget.today,
                        read: widget.todayBool,
                      ),
                      const SizedBox(height: 10),
                      NotificationCategoryBox(
                        title: "Yesterday",
                        notifications: widget.yesterday,
                        read: widget.yesterdayBool,
                      ),
                      const SizedBox(height: 10),
                      NotificationCategoryBox(
                        title: "Earlier",
                        notifications: widget.earlier,
                        read: widget.earlierBool,
                      ),
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

  const NotificationCategoryBox({
    super.key,
    required this.title,
    required this.notifications,
    required this.read,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
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
  final Function onTap;

  const NotificationBox({
    super.key,
    required this.id,
    required this.name,
    required this.subject,
    required this.msg,
    required this.isRead,
    required this.onTap,
  });

  @override
  _NotificationBoxState createState() => _NotificationBoxState();
}

class _NotificationBoxState extends State<NotificationBox> {
  bool isRead = false;

  @override
  void initState() {
    super.initState();
    isRead = widget.isRead;
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
                int maxLines = 2;

                TextPainter textPainter = TextPainter(
                  text: TextSpan(
                    text: widget.msg,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  maxLines: maxLines,
                  textDirection: TextDirection.ltr,
                )..layout(maxWidth: constraints.maxWidth);

                if (textPainter.didExceedMaxLines) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.msg,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          // text color white when isRead is false, else black
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Read more",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text(
                    widget.msg,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.subject,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                widget.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                constraints: const BoxConstraints(maxHeight: 500),
                child: SingleChildScrollView(
                  child: Text(
                    widget.msg,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
