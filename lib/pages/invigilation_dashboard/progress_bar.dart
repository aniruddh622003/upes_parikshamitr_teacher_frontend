import 'dart:async';
import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class InvigilatorProgress extends StatefulWidget {
  const InvigilatorProgress({super.key});

  @override
  State<InvigilatorProgress> createState() => _InvigilatorProgressState();
}

class _InvigilatorProgressState extends State<InvigilatorProgress> {
  late Timer _timer;
  late DateTime dt;

  late DateTime startTime;
  late DateTime endTime;

  late int remainingHours;
  late int remainingMinutesPart;

  late int remainingMinutes;

  @override
  void initState() {
    super.initState();

    dt = DateTime.now();
    setTimes();
    setTime();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setTimes();
      setTime();
    });
  }

  void setTimes() {
    dt = DateTime.now();
    if (((dt.hour * 100) + dt.minute) < 1300) {
      startTime = DateTime(dt.year, dt.month, dt.day, 10);
      endTime = DateTime(dt.year, dt.month, dt.day, 12);
    } else {
      startTime = DateTime(dt.year, dt.month, dt.day, 14);
      endTime = DateTime(dt.year, dt.month, dt.day, 16);
    }
  }

  void setTime() {
    remainingMinutes = endTime.difference(dt).inMinutes > 0
        ? endTime.difference(dt).inMinutes < 180
            ? endTime.difference(dt).inMinutes
            : 180
        : 0;
    setState(() {
      dt = DateTime.now();
      remainingMinutes = endTime.difference(dt).inMinutes > 0
          ? endTime.difference(dt).inMinutes < 120
              ? endTime.difference(dt).inMinutes
              : 120
          : 0;
      remainingHours = remainingMinutes ~/ 60;
      remainingMinutesPart = remainingMinutes % 60;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "$remainingHours hr $remainingMinutesPart min left",
              textScaler: const TextScaler.linear(1),
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: SizedBox(
            height: 8,
            child: LinearProgressIndicator(
              value: (remainingMinutes / 120),
              backgroundColor: grayLight,
              valueColor: const AlwaysStoppedAnimation<Color>(orange),
            ),
          ),
        ),
      ],
    );
  }
}
