import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text(
            "Notification",
            style: TextStyle(
              fontSize: fontMedium,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      NotificationCategoryBox(
                        title: "Today",
                        notifications: [
                          {
                            "name": "Aniruddh Upadhyay",
                            "subject": "Meeting",
                            "msg": "Please attend the meeting at 10 AM in 9104 and please be seated 5 minutes before the time. Thank you." +
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl. Sed euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl." +
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl. Sed euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl." +
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl. Sed euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl." +
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl. Sed euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl." +
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl. Sed euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl." +
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl. Sed euismod, nisl eget ultricies ultrices, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl. Extra text",
                          },
                          {
                            "name": "Khushi Gupta",
                            "subject": "Reminder",
                            "msg": "Don't forget the deadline. Thank you."
                          },
                        ],
                        read: [true, true],
                      ),
                      SizedBox(height: 10),
                      NotificationCategoryBox(
                        title: "Yesterday",
                        notifications: [
                          {
                            "name": "Khushi",
                            "subject": "Updates",
                            "msg":
                                "Project updates to be given today. No delay will be tolerated. Thank you."
                          },
                          {
                            "name": "Aniruddh",
                            "subject": "Task",
                            "msg":
                                "Complete the task by tomorrow. The tasks are monitored by the admin. Thank you."
                          },
                          {
                            "name": "Luffy",
                            "subject": "Announcement",
                            "msg": "New announcement."
                          },
                          {
                            "name": "Franky",
                            "subject": "Report",
                            "msg":
                                "Submit the report by tomorrow. Please give the hard copy. Thank you"
                          },
                        ],
                        read: [true, false, false, false],
                      ),
                      SizedBox(height: 10),
                      NotificationCategoryBox(
                        title: "Earlier",
                        notifications: [
                          {
                            "name": "Aarav",
                            "subject": "Notification",
                            "msg":
                                "Notification message will be triggered here. Thank you."
                          },
                          {
                            "name": "Aniruddh",
                            "subject": "Status",
                            "msg":
                                "Check the status of the task.If you face any issue, feel free to notify me.Thank you."
                          },
                          {
                            "name": "Khushi",
                            "subject": "Reminder",
                            "msg": "Reminder for tomorrow's meeting.Thank you"
                          },
                        ],
                        read: [true, true, true],
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
  final List<Map<String, String>> notifications;
  final List<bool> read;

  const NotificationCategoryBox({
    Key? key,
    required this.title,
    required this.notifications,
    required this.read,
  }) : super(key: key);

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
            name: notifications[index]['name']!,
            subject: notifications[index]['subject']!,
            msg: notifications[index]['msg']!,
            isRead: read[index],
            onTap: () {},
          ),
        ).expand((widget) => [widget, const SizedBox(height: 10)]).toList(),
      ],
    );
  }
}

class NotificationBox extends StatefulWidget {
  final String name;
  final String subject;
  final String msg;
  final bool isRead;
  final Function onTap;

  const NotificationBox({
    Key? key,
    required this.name,
    required this.subject,
    required this.msg,
    required this.isRead,
    required this.onTap,
  }) : super(key: key);

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
      onTap: () {
        if (!isRead) {
          widget.onTap();
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
          color: isRead ? Color(0xFF4A67D4) : Color(0xFF6E83DB),
          border: isRead
              ? Border.all(
                  color: Color(0xFF4A67D4),
                  width: 1,
                )
              : Border.all(
                  color: Color(0xFFBDBDBD),
                  width: 1,
                ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: isRead
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 5,
                    offset: Offset(0, 0),
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
                    "${widget.msg}",
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
                "${widget.subject}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                "${widget.name}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                constraints: BoxConstraints(maxHeight: 500),
                child: SingleChildScrollView(
                  child: Text(
                    "${widget.msg}",
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
