import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:developer' as developer;

import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class Step2Code extends StatefulWidget {
  final void Function(int) changeStep;
  const Step2Code({super.key, required this.changeStep});

  @override
  State<Step2Code> createState() => _Step2CodeState();
}

class _Step2CodeState extends State<Step2Code> {
  final codeController = TextEditingController();

  _validateEmail() {
    developer.log(codeController.text);
    widget.changeStep(2);
  }

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 17, 0),
                  child: Text(
                    "Please Verify yourself.",
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      fontSize: fontXLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 16, 10),
                  child: Text(
                    "You are almost there.",
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      color: grayDark,
                      fontSize: fontMedium,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
                child: SvgPicture.asset('android/assets/signinpage.svg'),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                    child: Text(
                      "Enter Verification Code.",
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: fontSmall,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                  child: TextFormField(
                    controller: codeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: blue50,
                      contentPadding: const EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: blue50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(color: blue50),
                      ),
                      hintText: 'Please enter the verification code',
                      hintStyle: const TextStyle(
                        color: black,
                        fontSize: fontSmall,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                      backgroundColor: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () {
                      _validateEmail();
                    },
                    child: const Text(
                      'Verify',
                      textScaler: TextScaler.linear(1),
                      style: TextStyle(
                        color: white,
                        fontSize: fontSmall,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
