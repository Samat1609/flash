import 'package:flash/constants/app_text_style.dart';
import 'package:flutter/material.dart';

class LoginRegisterWidget extends StatelessWidget {
  const LoginRegisterWidget(
      {super.key,
      required this.color,
      required this.text,
      required this.onTap});
  final Color color;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 345,
        height: 59,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyle.loginRegisterTextStyle,
          ),
        ),
      ),
    );
  }
}
