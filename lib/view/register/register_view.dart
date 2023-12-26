import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/constants/app_colors.dart';
import 'package:flash/view/home/home_view.dart';
import 'package:flash/view/login/login_view.dart';
import 'package:flash/widgets/text_login_register_widget.dart';
import 'package:flash/widgets/textform_widget.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  static const String route = 'RegisterView';

  final TextEditingController fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': fullName.text,
          'email': _email.text,
          'password': _password.text,
        })
        .then((value) => log("User Added"))
        .catchError((error) => log("Failed to add user: $error"));
  }

  Future<void> register() async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _email.text,
            password: _password.text,
          )
          .then(
            (value) => {
              addUser(),
            },
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff00062D),
              Color(0xff00041D),
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextLoginRegisterWidget(text: 'Register View'),
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
                      TextFormWidget(text: 'Full Name', controller: fullName),
                      const SizedBox(height: 20.0),
                      TextFormWidget(text: 'E-mail', controller: _email),
                      const SizedBox(height: 20.0),
                      TextFormWidget(text: 'Password', controller: _password),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Already have an account?'),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: const Color(0xff000063)),
                            onPressed: () {
                              Navigator.pushNamed(context, LoginView.route);
                            },
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: const Color(0xff000063),
                        ),
                        onPressed: () {
                          register();
                          Navigator.of(context).pushNamed(HomeView.route);
                        },
                        child: const Text('Register'),
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
