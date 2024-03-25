import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/doubt_section/contact_card.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class DoubtSection extends StatelessWidget {
  // final String roomNumber;
  const DoubtSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: blue,
        foregroundColor: white,
        title: const Text("Doubt Section"),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: white,
          statusBarIconBrightness: Brightness.dark,
        ),
        // automaticallyImplyLeading: false,
        // flexibleSpace: Container(
        //   color: primaryColor,
        //   child: Column(
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.fromLTRB(
        //             0, MediaQuery.of(context).padding.top + 10, 0, 20),
        //         child: Row(
        //           children: [
        //             IconButton(
        //               icon: const Icon(Icons.arrow_back, color: white),
        //               onPressed: () {
        //                 Navigator.pop(context);
        //               },
        //             ),
        //             const Text(
        //               'Doubt Section',
        //               textScaler: TextScaler.linear(1),
        //               style: TextStyle(
        //                 fontSize: fontMedium,
        //                 fontWeight: FontWeight.bold,
        //                 color: white,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       const Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         crossAxisAlignment: CrossAxisAlignment.center,
        //         children: <Widget>[
        //           Padding(
        //             padding: EdgeInsets.only(bottom: 35),
        //             child: Column(
        //               children: [
        //                 // Text(
        //                 //   "Room: $roomNumber",
        //                 //   textScaler: const TextScaler.linear(1),
        //                 //   style: const TextStyle(
        //                 //       fontSize: fontXLarge, color: Colors.white),
        //                 // ),
        //                 SizedBox(height: 2),
        //                 // CurrentTestTime(),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ),
      // Make the body cover the entire screen
      body: Expanded(
          child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height - 175,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Contacts for help",
                  textScaler: TextScaler.linear(1),
                  style: TextStyle(fontSize: fontMedium),
                ),
              ),
            ),
            ContactCard(
              name: 'Dr. Ajay Prasad',
              designation: 'Center Superintendent SoCS',
              phoneNumber: '9690129280',
              onMessagePressed: () {
                // Handle message icon pressed for John Doe
              },
            ),
            ContactCard(
              name: 'Dr. Rahul Kumar Singh',
              designation: 'Examination Committee Member',
              phoneNumber: '9781016195',
              onMessagePressed: () {
                // Handle message icon pressed for Jane Smith
              },
            ),
            ContactCard(
              name: 'Dr. Abhijeet Kumar',
              designation: 'Examination Committee Member',
              phoneNumber: '9311360747',
              onMessagePressed: () {
                // Handle message icon pressed for Bob Johnson
              },
            ),
            ContactCard(
              name: 'Dr. Dhirendra Sharma',
              designation: 'Examination Committee Member',
              phoneNumber: '8370033126',
              onMessagePressed: () {
                // Handle message icon pressed for Alice Brown
              },
            ),
            ContactCard(
              name: 'Dr. Rohit Shrivastava',
              designation: 'Examination Committee Member',
              phoneNumber: '9725313511',
              onMessagePressed: () {
                // Handle message icon pressed for Alice Brown
              },
            ),
            ContactCard(
              name: 'Dr. Sanoj Kumar',
              designation: 'Examination Committee Member',
              phoneNumber: '9058523010',
              onMessagePressed: () {
                // Handle message icon pressed for Alice Brown
              },
            ),
            ContactCard(
              name: 'Dr. Virender Kadyan',
              designation: 'Application related queries',
              phoneNumber: '9992037007',
              onMessagePressed: () {
                // Handle message icon pressed for Alice Brown
              },
            ),
          ],
        ),
      )),
    );
  }
}
