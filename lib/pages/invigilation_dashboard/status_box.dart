import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

Widget getStatusBox(String name, {bool roundedBorder = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 345,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          decoration: BoxDecoration(
            color: blueXLight,
            borderRadius: roundedBorder
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )
                : null,
            border: const Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          child: Text(
            name,
            textScaler: const TextScaler.linear(1),
            style: const TextStyle(
              fontSize: fontSmall,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget getStatusBoxWithText(String name, String text, Color textColor,
    {bool roundedBorder = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 345,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          decoration: BoxDecoration(
            color: blueXLight,
            borderRadius: roundedBorder
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )
                : null,
            border: const Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                textScaler: const TextScaler.linear(1),
                style: const TextStyle(
                  fontSize: fontSmall,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              Text(
                text,
                textScaler: const TextScaler.linear(1),
                style: TextStyle(
                  fontSize: fontXSmall,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget getStatusBoxWithButton(
    String name, VoidCallback onPressed, String buttonText,
    {bool roundedBorder = false}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 345,
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Container(
          padding: const EdgeInsets.only(left: 13, right: 7),
          decoration: BoxDecoration(
            color: blueXLight,
            borderRadius: roundedBorder
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                  )
                : null,
            border: const Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                textScaler: const TextScaler.linear(1),
                style: const TextStyle(
                  fontSize: fontSmall,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              ElevatedButton(
                onPressed: onPressed,
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 30),
                  ),
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(0, 40)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(secondaryColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                child: Text(
                  buttonText,
                  textScaler: const TextScaler.linear(1),
                  style: const TextStyle(fontSize: fontXSmall, color: white),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
