// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/login_page.dart';

class HomeActivity extends StatefulWidget {
  const HomeActivity({super.key});

  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  CarouselSlider(
                    items: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(50, 80, 26, 20),
                        child: SvgPicture.asset('android/assets/carousel1.svg'),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50, 80, 26, 20),
                        child: SvgPicture.asset('android/assets/carousel2.svg'),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(50, 80, 26, 20),
                        child: SvgPicture.asset('android/assets/carousel3.svg'),
                      ),
                    ],
                    options: CarouselOptions(
                      height: 350,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                              text: _currentIndex == 0
                                  ? 'Track Evaluation Progress in '
                                  : ''),
                          TextSpan(
                            text: _currentIndex == 0 ? 'Real-Time' : '',
                            style: TextStyle(
                                color: _currentIndex == 0
                                    ? Colors.orange
                                    : Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: _currentIndex == 1
                                  ? 'View Schedule and Timelines\n'
                                  : ''),
                          TextSpan(
                            text: _currentIndex == 1 ? 'On-The-Go' : '',
                            style: TextStyle(
                                color: _currentIndex == 1
                                    ? Colors.orange
                                    : Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                              text: _currentIndex == 2
                                  ? 'Track, Verify and Invigilate Students during '
                                  : ''),
                          TextSpan(
                            text: _currentIndex == 2 ? 'Examinations' : '',
                            style: TextStyle(
                                color: _currentIndex == 2
                                    ? Colors.orange
                                    : Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextButton(
                style: TextButton.styleFrom(
                  minimumSize: const Size(310, 40),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInPage()));
                },
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "UPES ParikshaMitr",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
