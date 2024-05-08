import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});
  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final mentor = {
    'name': 'Virender Kadyan',
    'title': 'Associate Professor\nUPES Dehradun',
    'phone': '9992037007',
    'email': 'vkadyan@ddn.upes.ac.in',
    'designation': 'Head Research Lab: SLRC, MIRC',
  };

  final teamMembers = [
    {
      'name': 'Aniruddh Upadhyay',
      'title': 'Assoc Product Developer\nBMC Software Pvt. Ltd.',
      'qualification': 'B-Tech Hons. CSE AIML (UPES)',
      'phone': '7999928830',
      'email': 'aniruddh622003@gmail.com',
    },
    {
      'name': 'Khushi Gupta',
      'title': 'Technical Associate\nOnceHub Technologies Pvt. Ltd.',
      'qualification': 'B-Tech CSE AIML (UPES)',
      'phone': '7078870401',
      'email': '500086849@stu.upes.ac.in',
    },
    {
      'name': 'Aarav Sharma',
      'title': 'Business Analyst\nBarclays Bank PLC',
      'qualification': 'B-Tech Hons. CSE AIML (UPES)',
      'phone': '9810365071',
      'email': 'mailaarav2002@gmail.com',
    },
    {
      'name': 'Eshan Dutta',
      'title': 'Software Developer\nTata Technologies',
      'qualification': 'B-Tech Hons. CSE AIML (UPES)',
      'phone': '9413766488',
      'email': 'eshandutta06@gmail.com',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: white,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: const Text(
          'Our Team',
          textScaler: TextScaler.linear(1),
          style: TextStyle(color: white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: white),
          onPressed: () {
            try {
              Navigator.of(context).pop();
            } catch (e) {
              errorDialog(context, e.toString());
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Project Mentor",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text(
                mentor['name'] ?? "Null",
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${mentor['title'] ?? 'Null'}\n${mentor['email'] ?? 'Null'}\n${mentor['designation'] ?? 'Null'}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.phone),
                onPressed: () async {
                  var phone = mentor['phone'];
                  if (phone != null) {
                    var url = Uri.parse('tel:$phone');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }
                },
              ),
            ),
            // Team members
            const Padding(
              padding: EdgeInsets.only(top: 0.0, left: 16.0, right: 16.0),
              child: Text(
                'Team Members',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true, // Prevent excessive scrolling
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling
              itemCount: teamMembers.length, // Calculate number of rows
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(teamMembers[index]['name'] ?? 'Null'),
                  subtitle: Text(
                      '${teamMembers[index]['title'] ?? 'Null'}\n${teamMembers[index]['qualification'] ?? 'Null'}\n${teamMembers[index]['email'] ?? 'Null'}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.phone),
                    onPressed: () async {
                      var phone = teamMembers[index]['phone'];
                      if (phone != null) {
                        var url = Uri.parse('tel:$phone');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      }
                    },
                  ),
                );

                // Handle tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
