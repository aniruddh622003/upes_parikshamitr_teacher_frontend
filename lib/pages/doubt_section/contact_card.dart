import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/doubt_section/chat.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class ContactCard extends StatelessWidget {
  final String name;
  final String designation;
  final VoidCallback onMessagePressed;

  const ContactCard({
    super.key,
    required this.name,
    required this.designation,
    required this.onMessagePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              personName: name,
              designation: designation,
            ),
          ),
        );
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
                              style: const TextStyle(
                                  fontSize: fontMedium,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              designation,
                              style: const TextStyle(fontSize: fontSmall),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed:
                            // onMessagePressed,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                personName: name,
                                designation: designation,
                              ),
                            ),
                          );
                        },
                        icon: SvgPicture.asset(
                          'android/assets/msg.svg',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )

          // ListTile(
          //   title: Text(
          //     name,
          //     style: TextStyle(fontSize: fontMedium, fontWeight: FontWeight.bold),
          //   ),
          //   subtitle: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         child: Text(
          //           designation,
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
