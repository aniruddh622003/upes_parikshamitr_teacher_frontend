import 'dart:async';

import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:intl/intl.dart';

class CurrentTimeWidget extends StatefulWidget {
  const CurrentTimeWidget({super.key});

  @override
  _CurrentTimeWidgetState createState() => _CurrentTimeWidgetState();
}

class _CurrentTimeWidgetState extends State<CurrentTimeWidget> {
  String currentTime = '';
  late String testTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _updateCurrentTime();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  // Should use Timer.periodic here as Future.delayed se bohot saare recursive calls add hore h system memory m.
  void _updateCurrentTime() {
    setState(() {
      currentTime = _getCurrentTime();
      testTime = _calculateTestTime();
    });
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh:mm a').format(now);
    return formattedTime;
  }

  String _calculateTestTime() {
    DateTime now = DateTime.now();
    if (now.hour < 10) {
      return "10:00 AM - 1:00 PM";
    } else if (now.hour < 14) {
      return "2:00 - 5:00 PM";
    } else {
      return "Test time has passed";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(currentTime,
            style: const TextStyle(fontSize: 32, color: Colors.white)),
        const SizedBox(height: 10),
        Text(
          'Test Time: $testTime',
          style: const TextStyle(fontSize: fontMedium, color: Colors.white),
        ),
      ],
    );
  }
}
