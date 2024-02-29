import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlyingSquad extends StatelessWidget {
  final String title;
  const FlyingSquad({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      width: double.infinity,
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
              textScaler: const TextScaler.linear(1),
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
              textScaler: TextScaler.linear(1),
              "Refresh",
              style: TextStyle(fontSize: fontXSmall, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
