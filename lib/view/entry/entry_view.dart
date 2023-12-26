import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash/constants/app_colors.dart';
import 'package:flash/constants/app_text_style.dart';
import 'package:flash/view/login/login_view.dart';
import 'package:flash/view/register/register_view.dart';
import 'package:flash/widgets/login_register_widget.dart';
import 'package:flutter/material.dart';

class EntryView extends StatelessWidget {
  const EntryView({super.key});

  static const String route = 'EntryView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        backgroundColor: AppColors.appBarColor,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff001287),
            Color(0xff00020F),
          ], begin: Alignment.bottomRight, end: Alignment.topLeft),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 20.0,
                ),
                child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    WavyAnimatedText('Flash Chat',
                        textStyle: AppTextStyle.flashChatTextTextStyle),
                  ],
                  isRepeatingAnimation: true,
                ),
              ),
              const SizedBox(height: 20.0),
              LoginRegisterWidget(
                color: AppColors.loginContainerColor,
                text: 'Login',
                onTap: () {
                  Navigator.pushNamed(context, LoginView.route);
                },
              ),
              const SizedBox(height: 20.0),
              LoginRegisterWidget(
                color: AppColors.registerContainerColor,
                text: 'Register',
                onTap: () {
                  Navigator.pushNamed(context, RegisterView.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
