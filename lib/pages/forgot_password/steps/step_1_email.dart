import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';

class Step1Email extends StatefulWidget {
  final void Function(int) changeStep;
  const Step1Email({super.key, required this.changeStep});

  @override
  State<Step1Email> createState() => _Step1EmailState();
}

class _Step1EmailState extends State<Step1Email> {
  // Callback function to change the step from parent

  @override
  Widget build(BuildContext context) {
    // return TextButton(
    //     onPressed: () => widget.changeStep(1), child: const Text('Next'));
    return Container(
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
            minWidth: MediaQuery.of(context).size.width),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 20, 17, 0),
                  child: Text(
                    "Forgot your Password?",
                    style: TextStyle(
                      fontSize: fontXLarge,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 0, 16, 10),
                  child: Text(
                    "We are here to help.",
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
                Padding(
                    padding: EdgeInsets.fromLTRB(25, 0, 25, 10),
                    child: Text(
                      "Enter Your Email Address.",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: fontSmall,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: blue50,
                      contentPadding: EdgeInsets.all(15),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: blue50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(color: blue50),
                      ),
                      hintText: 'Enter your email address',
                      hintStyle: TextStyle(
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
                      widget.changeStep(1);
                    },
                    child: const Text(
                      'Send Verification Code',
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
