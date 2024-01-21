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
  // String input = '10:00 AM';

  late DateTime startTime;
  late DateTime endTime;

  late int remainingHours;
  late int remainingMinutesPart;

  @override
  void initState() {
    super.initState();

    dt = DateTime.now();
    startTime = dt.subtract(const Duration(hours: 1));
    endTime = startTime.add(const Duration(hours: 3));

    setTime();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      setTime();
    });
  }

  void setTime() {
    int remainingMinutes = endTime.difference(dt).inMinutes;
    setState(() {
      dt = DateTime.now();
      remainingMinutes = endTime.difference(dt).inMinutes;
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
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: SizedBox(
            height: 8,
            child: LinearProgressIndicator(
              value: (dt.difference(startTime).inMinutes / 180),
              backgroundColor: grayLight,
              valueColor: const AlwaysStoppedAnimation<Color>(orange),
            ),
          ),
        ),
      ],
    );
  }
}
