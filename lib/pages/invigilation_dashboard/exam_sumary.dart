import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class CourseSubject {
  final String course;
  final String subject;

  CourseSubject(this.course, this.subject);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CourseSubject &&
        other.course == course &&
        other.subject == subject;
  }

  @override
  int get hashCode => course.hashCode ^ subject.hashCode;
}

class ExamSummary extends StatefulWidget {
  final Map roomDetails;
  const ExamSummary({super.key, required this.roomDetails});

  @override
  State<ExamSummary> createState() => _ExamSummaryState();
}

class _ExamSummaryState extends State<ExamSummary> {
  String formattedDate = DateFormat('EEEE, d MMMM, y').format(DateTime.now());
  late List seatingPlan;
  int totalUfm = 0;

  @override
  void initState() {
    super.initState();
    seatingPlan = widget.roomDetails['data']['seating_plan'];
  }

  List<Widget> makeSummaryItems(List seatingPlan) {
    List<Widget> items = [];
    var groupedData = groupBy(
        seatingPlan, (obj) => CourseSubject(obj['course'], obj['subject']));

    List<Map<String, dynamic>> details = [];

    groupedData.forEach((key, value) {
      int presentCount =
          value.where((student) => student['attendance'] == true).length;
      int absentCount =
          value.where((student) => student['attendance'] == false).length;
      int debarredCount =
          value.where((student) => student['eligible'] != 'YES').length;
      int ufmCount = value.where((student) => student['UFM'] != null).length;
      totalUfm += ufmCount;
      int totalStudents = value.length;
      absentCount -= debarredCount;
      details.add({
        'course': key.course,
        'subject': key.subject,
        'subject_code': value[0]['subject_code'],
        'present': presentCount,
        'absent': absentCount,
        'debarred': debarredCount,
        'ufm': ufmCount,
        'total': totalStudents
      });
    });

    for (var detail in details) {
      items.add(ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: blue50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        detail['course'],
                        textScaler: const TextScaler.linear(1),
                        style:
                            const TextStyle(fontSize: fontMedium, color: white),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: white,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          detail['total'].toString(),
                          textScaler: const TextScaler.linear(1),
                          style: const TextStyle(color: blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  detail['subject'],
                  textScaler: const TextScaler.linear(1),
                  style: const TextStyle(fontSize: fontMedium),
                ),
              ),
              Container(
                color: gray,
                height: 1,
                width: double.infinity,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text(
                  detail['subject_code'].toString(),
                  textScaler: const TextScaler.linear(1),
                  style: const TextStyle(fontSize: fontMedium),
                ),
              ),
              Container(
                color: gray,
                height: 1,
                width: double.infinity,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        "Present",
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(fontSize: fontMedium, color: black),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          detail['present'].toString(),
                          textScaler: const TextScaler.linear(1),
                          style: const TextStyle(color: white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: gray,
                height: 1,
                width: double.infinity,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        "Absent",
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(fontSize: fontMedium, color: black),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          detail['absent'].toString(),
                          textScaler: const TextScaler.linear(1),
                          style: const TextStyle(color: white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: gray,
                height: 1,
                width: double.infinity,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        "Debarred",
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(fontSize: fontMedium, color: black),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          detail['debarred'].toString(),
                          textScaler: const TextScaler.linear(1),
                          style: const TextStyle(color: white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: gray,
                height: 1,
                width: double.infinity,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Flexible(
                      child: Text(
                        "UFMs Issued",
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(fontSize: fontMedium, color: black),
                      ),
                    ),
                    Container(
                      width: 35,
                      height: 35,
                      decoration: const BoxDecoration(
                        color: blue,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          detail['ufm'].toString(),
                          textScaler: const TextScaler.linear(1),
                          style: const TextStyle(color: white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ));
      items.add(const SizedBox(height: 10));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        foregroundColor: white,
        title: const Text(
          'Exam Summary',
          textScaler: TextScaler.linear(1),
        ),
      ),
      backgroundColor: blue,
      body: Column(
        children: [
          Center(
              child: Text(
            formattedDate,
            textScaler: const TextScaler.linear(1),
            style: const TextStyle(fontSize: fontLarge, color: white),
          )),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            decoration: const BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: ListView(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text('Room No.',
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(fontSize: fontLarge, color: black)),
                ),
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 30),
                    decoration: BoxDecoration(
                      color: orange,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      widget.roomDetails['data']['room_no'].toString(),
                      textScaler: const TextScaler.linear(1),
                      style: const TextStyle(
                          fontSize: fontLarge, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text("Examination Subjects",
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(fontSize: fontSmall + 2)),
                ...makeSummaryItems(seatingPlan),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        'Total Students',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(fontSize: fontMedium),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Debarred Students',
                        textScaler: TextScaler.linear(1),
                        style: TextStyle(fontSize: fontMedium),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.roomDetails['data']['total_students'].toString(),
                      textScaler: const TextScaler.linear(1),
                      style:
                          const TextStyle(color: orange, fontSize: fontLarge),
                    ),
                    Text(
                      (widget.roomDetails['data']['total_students'] -
                              widget.roomDetails['data']['eligible_students'])
                          .toString(),
                      textScaler: const TextScaler.linear(1),
                      style:
                          const TextStyle(color: orange, fontSize: fontLarge),
                    ),
                  ],
                ),
                const Text(
                  'Total UFMs',
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(fontSize: fontMedium),
                ),
                Text(
                  totalUfm.toString(),
                  textScaler: const TextScaler.linear(1),
                  style: const TextStyle(color: orange, fontSize: fontLarge),
                ),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
