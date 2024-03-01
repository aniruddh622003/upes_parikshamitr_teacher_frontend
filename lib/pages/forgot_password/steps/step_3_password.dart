import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:developer' as developer;

import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class Step3Pass extends StatefulWidget {
  final void Function(int) changeStep;
  const Step3Pass({super.key, required this.changeStep});

  @override
  State<Step3Pass> createState() => _Step3PassState();
}

class _Step3PassState extends State<Step3Pass> {
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  bool _obscureText = true;

  _validateEmail() {
    developer.log(passController.text);
    developer.log(confirmPassController.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 17, 0),
                  child: Text(
                    "Reset Your Password.",
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
                      "Enter New Password.",
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
                    obscureText: _obscureText,
                    controller: passController,
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
                      hintText: 'Please enter a new password',
                      hintStyle: const TextStyle(
                        color: black,
                        fontSize: fontSmall,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    child: Text(
                      "Confirm Password.",
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
                    obscureText: _obscureText,
                    controller: confirmPassController,
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
                      hintText: 'Please re-enter the password',
                      hintStyle: const TextStyle(
                        color: black,
                        fontSize: fontSmall,
                        fontWeight: FontWeight.w700,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: blue,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
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
                      'Reset Password',
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
