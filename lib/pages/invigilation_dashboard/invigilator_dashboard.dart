import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/flying_squad.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/progress_bar.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/status_box.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/invigilation_dashboard/current_time.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvigilatorDashboard extends StatelessWidget {
  const InvigilatorDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          toolbarHeight: 220,
          flexibleSpace: Container(
            color: primaryColor,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 58.0, 101, 20),
                  child: Text(
                    'Invigilation Dashboard',
                    style: TextStyle(
                      fontSize: fontMedium,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: Column(
                        children: [
                          const CurrentTimeWidget(),
                          getPhaseText(),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: InvigilatorProgress(),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 27, top: 20, right: 38),
                      child: SvgPicture.asset('android/assets/ufm.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 28),
                      child:
                          SvgPicture.asset('android/assets/supplementary.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                      ),
                      child: SvgPicture.asset('android/assets/controller.svg'),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 20, right: 20),
                      child: SvgPicture.asset('android/assets/doubt.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 30),
                      child: SvgPicture.asset('android/assets/qr.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SvgPicture.asset('android/assets/seatingplan.svg'),
                    ),
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
