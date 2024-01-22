import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/forgot_password/steps/step_1_email.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/forgot_password/steps/step_2_code.dart';

class ForgotPasswordProgressTrack extends StatefulWidget {
  const ForgotPasswordProgressTrack({super.key});

  @override
  State<ForgotPasswordProgressTrack> createState() =>
      _ForgotPasswordProgressTrackState();
}

class _ForgotPasswordProgressTrackState
    extends State<ForgotPasswordProgressTrack> {
  int _currentStep = 0;

  _changeStep(int step) {
    setState(() {
      _currentStep = step;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentStep == 0) {
      return Step1Email(
        changeStep: _changeStep,
      );
    } else if (_currentStep == 1) {
      return Step2Code(changeStep: _changeStep);
    } else {
      return const Placeholder();
    }
  }
}
