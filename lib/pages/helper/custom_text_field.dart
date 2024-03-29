import 'package:flutter/material.dart';
import 'package:upes_parikshamitr_teacher_frontend/pages/theme.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  const CustomTextField(
      {super.key,
      required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.inputFormatters = const []});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: black),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: gray, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: blue, width: 2.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        fillColor: blueXLight,
      ),
    );
  }
}
