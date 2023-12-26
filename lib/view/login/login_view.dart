import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/constants/app_colors.dart';
import 'package:flash/view/home/home_view.dart';
import 'package:flash/view/register/register_view.dart';
import 'package:flash/widgets/text_login_register_widget.dart';
import 'package:flash/widgets/textform_widget.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  static const String route = 'LoginView';
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
      log('user credential==>$credential');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color(0xff001287),
              Color(0xff00020F),
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextLoginRegisterWidget(text: 'LoginView'),
              const SizedBox(height: 20.0),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                color: AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20.0),
                      TextFormWidget(text: 'E-mail', controller: _email),
                      const SizedBox(height: 20.0),
                      TextFormWidget(
                        text: 'Password',
                        suffixIcon: const Icon(Icons.visibility),
                        controller: _password,
                      ),
                      const SizedBox(height: 15.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('''Don't have an account?'''),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: const Color(0xff001389),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, RegisterView.route);
                            },
                            child: const Text('Register'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff001389),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          signIn();
                          Navigator.pushNamed(context, HomeView.route);
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
