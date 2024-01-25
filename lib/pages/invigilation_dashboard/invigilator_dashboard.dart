import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/attendance/attendance_popup.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/doubt_section/doubt_section.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/flying_squad.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/progress_bar.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/seating_arrangement.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/status_box.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/current_time.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvigilatorDashboard extends StatelessWidget {
  const InvigilatorDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double paddingTop = MediaQuery.of(context).padding.top.toDouble();
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark,
          ),
          toolbarHeight: 250,
          flexibleSpace: Container(
            color: primaryColor,
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(15, paddingTop + 15, 0, 20),
                      child: const Text(
                        'Invigilation Dashboard',
                        style: TextStyle(
                          fontSize: fontMedium,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Column(
                        children: [
                          const CurrentTimeWidget(),
                          getPhaseText(),
                        ],
                      ),
                    )),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 14),
                  child: InvigilatorProgress(),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SvgPicture.asset('android/assets/ufm.svg'),
                    ),
                    Expanded(
                      child:
                          SvgPicture.asset('android/assets/supplementary.svg'),
                    ),
                    Expanded(
                      child: SvgPicture.asset('android/assets/controller.svg'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const DoubtSection(roomNumber: "1101"))),
                      child: SvgPicture.asset('android/assets/doubt.svg'),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => attendancePopup(context),
                      child: SvgPicture.asset('android/assets/qr.svg'),
                    )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SeatingArrangement(
                                    roomId: "65b2757805449484d0350967",
                                  ))),
                      child: SvgPicture.asset('android/assets/seatingplan.svg'),
                    )),
                  ],
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FlyingSquad(title: 'Flying Squad'),
                      getStatusBox("Dr. Rishi Madan", roundedBorder: false),
                      getStatusBox("Dr. Rishi Madan", roundedBorder: false),
                      getStatusBox("Dr. Rishi Madan", roundedBorder: true),
                      const FlyingSquad(title: 'Check Supplies'),
                      getStatusBoxWithText(
                          "Answer Sheet", "30/30 Received", Colors.green,
                          roundedBorder: false),
                      getStatusBoxWithButton("B Sheet", () {}, "22/55 pending",
                          roundedBorder: false),
                      getStatusBoxWithText(
                          "Dr. Rishi Madan", "0/55 Received", Colors.red,
                          roundedBorder: true),
                      const Padding(padding: EdgeInsets.only(bottom: 15))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget getPhaseText() {
    DateTime currentTime = DateTime.now();
    int currentHour = currentTime.hour;
    String period = currentHour >= 12 ? 'PM' : 'AM';

    if (currentHour >= 10 && currentHour < 13 && period == 'AM') {
      return const Text(
        '(Phase I)',
        style: TextStyle(
          fontSize: fontMedium,
          color: white,
          fontWeight: FontWeight.normal,
        ),
      );
    } else {
      return const Text(
        '(Phase II)',
        style: TextStyle(
          fontSize: fontMedium,
          color: white,
          fontWeight: FontWeight.normal,
        ),
      );
    }
  }
}
