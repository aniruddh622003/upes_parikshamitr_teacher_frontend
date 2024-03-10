// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String designation;
  final String phoneNumber;
  final VoidCallback onMessagePressed;

  const ContactCard({
    super.key,
    required this.name,
    required this.designation,
    required this.onMessagePressed,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          // const phoneNumber = '9406803371';
          final telUrl = Uri.parse('tel:$phoneNumber');
          if (await canLaunchUrl(telUrl)) {
            await launchUrl(telUrl);
          } else {
            // throw 'Could not launch $telUrl';
          }
        } catch (e) {
          errorDialog(context, e.toString());
        }
      },
      child: Card(
          color: Colors.white,
          elevation: 0,
          margin: const EdgeInsets.all(0),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              textScaler: const TextScaler.linear(1),
                              style: const TextStyle(
                                  fontSize: fontMedium,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              designation,
                              textScaler: const TextScaler.linear(1),
                              style: const TextStyle(fontSize: fontSmall),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          try {
                            // const phoneNumber = '9406803371';
                            final telUrl = Uri.parse('tel:$phoneNumber');
                            if (await canLaunchUrl(telUrl)) {
                              await launchUrl(telUrl);
                            } else {
                              // throw 'Could not launch $telUrl';
                            }
                          } catch (e) {
                            errorDialog(context, e.toString());
                          }
                        },
                        icon: SvgPicture.asset(
                          'android/assets/call.svg',
                        ),
                      ),
                      // IconButton(
                      //   onPressed:
                      //       // onMessagePressed,
                      //       () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => ChatScreen(
                      //           personName: name,
                      //           designation: designation,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   icon: SvgPicture.asset(
                      //     'android/assets/msg.svg',
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          )

          // ListTile(
          //   title: Text(
          //     name,
          //textScaler: const TextScaler.linear(1),
          //     style: TextStyle(fontSize: fontMedium, fontWeight: FontWeight.bold),
          //   ),
          //   subtitle: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         child: Text(
          //           designation,
          //textScaler: const TextScaler.linear(1),
          //           style: TextStyle(fontSize: fontSmall),
          //         ),
          //       ),
          //       SvgPicture.asset(
          //         'android/assets/msg.svg',
          //       ),
          //     ],
          //   ),
          // ),
          ),
    );
  }
}
