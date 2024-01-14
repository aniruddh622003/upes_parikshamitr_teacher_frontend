import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeActivity extends StatefulWidget {
  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: ListView(
        children: [
          CarouselSlider(
            items: [
              Container(
                margin: EdgeInsets.fromLTRB(50, 80, 26, 20),
                child: SvgPicture.asset('android/assets/carousel1.svg'),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(50, 80, 26, 20),
                child: SvgPicture.asset('android/assets/carousel2.svg'),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(50, 80, 26, 20),
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
            padding: EdgeInsets.fromLTRB(25, 0, 25, 79),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
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
                        color:
                            _currentIndex == 0 ? Colors.orange : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: _currentIndex == 1
                          ? 'View Schedule and Timelines\n'
                          : ''),
                  TextSpan(
                    text: _currentIndex == 1 ? 'On-The-Go' : '',
                    style: TextStyle(
                        color:
                            _currentIndex == 1 ? Colors.orange : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                      text: _currentIndex == 2
                          ? 'Track, Verify and Invigilate Students during '
                          : ''),
                  TextSpan(
                    text: _currentIndex == 2 ? 'Examinations' : '',
                    style: TextStyle(
                        color:
                            _currentIndex == 2 ? Colors.orange : Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(25, 50, 25, 60),
            child: TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(310, 40),
                backgroundColor: Colors.grey[400],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: () {},
              child: Text(
                'Get Started',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(115, 0, 115, 30),
            child: Text(
              "UPES Pariksha Mitr",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
