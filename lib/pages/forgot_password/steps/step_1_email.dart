import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/helper/error_dialog.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class Step1Email extends StatefulWidget {
  final void Function(int) changeStep;
  const Step1Email({super.key, required this.changeStep});

  @override
  State<Step1Email> createState() => _Step1EmailState();
}

class _Step1EmailState extends State<Step1Email> {
  final emailController = TextEditingController();

  _validateEmail() {
    developer.log(emailController.text);
    widget.changeStep(1);
  }

  @override
  void dispose() {
    // emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return TextButton(
    //     onPressed: () => widget.changeStep(1), child: const Text(textScaler: const TextScaler.linear(1),'Next'));
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
                    "Forgot your Password?",
                    textScaler: TextScaler.linear(1),
                    style: TextStyle(
                      fontSize: fontXLarge,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 16, 10),
                  child: Text(
                    "We are here to help.",
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
                      "Enter Your Email Address.",
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
                    controller: emailController,
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
                      hintText: 'Enter your email address',
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
                      try {
                        _validateEmail();
                      } catch (e) {
                        errorDialog(context, e.toString());
                      }
                    },
                    child: const Text(
                      'Send Verification Code',
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
