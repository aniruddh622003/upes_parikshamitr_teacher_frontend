import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlyingSquad extends StatelessWidget {
  final String title;
  const FlyingSquad({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      width: 345,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
          color: blue,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                color: white,
                fontSize: fontSmall,
                fontWeight: FontWeight.normal,
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.only(right: 7),
              child: SvgPicture.asset('android/assets/refresh.svg'),
            ),
            const Text(
              "Refresh",
              style: TextStyle(fontSize: fontXSmall, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
