import 'package:flash/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TextLoginRegisterWidget extends StatelessWidget {
  const TextLoginRegisterWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: AppColors.mainColor,
          fontSize: 35,
          fontWeight: FontWeight.w500),
    );
  }
}
