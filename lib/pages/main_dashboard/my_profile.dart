import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/api/get_teacher_details.dart'; // replace with the actual file name
import 'dart:convert';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});
  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
  Future<Map<String, dynamic>> getTeacherData() async {
    final response = await getTeacherDetails();
    final body = jsonDecode(response.body);
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: blue,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'My Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: getTeacherData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final data = snapshot.data;
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                                'assets/avatar.png'), // replace with your asset image
                            radius: 30,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            '${data?['data']['name']}', // use the 'name' field from the data
                            textScaler: const TextScaler.linear(1),
                            style: const TextStyle(
                                color: white, fontSize: fontLarge),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    Expanded(
                      child: Container(
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'School',
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: fontMedium,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${data?['data']['school']}',
                                    textScaler: const TextScaler.linear(1),
                                    style: const TextStyle(
                                      fontSize: fontMedium,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'SAP ID',
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: fontMedium,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${data?['data']['sap_id']}',
                                    textScaler: const TextScaler.linear(1),
                                    style: const TextStyle(
                                      fontSize: fontMedium,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Phone',
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: fontMedium,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${data?['data']['phone']}',
                                    textScaler: const TextScaler.linear(1),
                                    style: const TextStyle(
                                      fontSize: fontMedium,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  const Text(
                                    'Email',
                                    textScaler: TextScaler.linear(1),
                                    style: TextStyle(
                                        color: blue,
                                        fontSize: fontMedium,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${data?['data']['email']}',
                                    textScaler: const TextScaler.linear(1),
                                    style: const TextStyle(
                                      fontSize: fontMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Add the rest of your page content here
                  ]);
            }
          },
        ));
  }
}
