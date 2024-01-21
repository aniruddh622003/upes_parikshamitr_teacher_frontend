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

  @override
  void initState() {
    super.initState();
    _updateCurrentTime();
  }

  // Should use Timer.periodic here as Future.delayed se bohot saare recursive calls add hore h system memory m.
  void _updateCurrentTime() {
    setState(() {
      currentTime = _getCurrentTime();
    });
    Future.delayed(Duration(seconds: 1), _updateCurrentTime);
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = DateFormat('hh:mm a').format(now);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currentTime',
      style: TextStyle(fontSize: fontXLarge, color: Colors.white),
    );
  }
}
