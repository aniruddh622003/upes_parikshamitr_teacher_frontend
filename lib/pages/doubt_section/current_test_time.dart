// ignore_for_file: library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class CurrentTestTime extends StatefulWidget {
  const CurrentTestTime({super.key});

  @override
  _CurrentTestTimeState createState() => _CurrentTestTimeState();
}

class _CurrentTestTimeState extends State<CurrentTestTime> {
  late Timer _timer;
  late String testTime;
  @override
  void initState() {
    super.initState();
    _updateCurrentTime();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _updateCurrentTime();
    });
  }

  // Should use Timer.periodic here as Future.delayed se bohot saare recursive calls add hore h system memory m.
  void _updateCurrentTime() {
    setState(() {
      testTime = _calculateTestTime();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
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
    return Text(
      testTime,
      textScaler: const TextScaler.linear(1),
      style: const TextStyle(fontSize: fontMedium, color: Colors.white),
    );
  }
}
