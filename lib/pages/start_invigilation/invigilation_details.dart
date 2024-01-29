import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/start_invigilation/confirm_invigilation_card.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/start_invigilation/invigilation_details_card.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class InvigilationDetails extends StatelessWidget {
  const InvigilationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: white,
            statusBarIconBrightness: Brightness.dark,
          ),
          title: const Text(
            'Details',
            style: TextStyle(
              color: white,
            ),
          ),
          backgroundColor: blue,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: blue,
        body: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome, <username>',
                  style: TextStyle(
                    color: white,
                    fontSize: fontMedium,
                  ),
                ),
              ),
            ),
            const InvigilationDetailsCard(),
            Container(
              margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
              width: MediaQuery.of(context).size.width * 1,
              child: ElevatedButton(
                onPressed: () {
                  confirmInvigilationCard(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: orange, // Background color
                  foregroundColor: white, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Request for Approval',
                      style: TextStyle(fontSize: fontMedium),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
            //   width: MediaQuery.of(context).size.width * 1,
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Navigator.push(
            //       //   context,
            //       //   MaterialPageRoute(builder: (context) => const Dashboard()),
            //       // );
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.transparent, // Background color
            //       foregroundColor: white, // Text color
            //       side: const BorderSide(
            //           color: white, width: 2), // Border color and width
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //     ),
            //     child: const Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text(
            //           'Change Invigilation (3 left)',
            //           style: TextStyle(fontSize: fontMedium),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
