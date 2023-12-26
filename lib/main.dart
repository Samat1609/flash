import 'package:firebase_core/firebase_core.dart';
import 'package:flash/view/entry/entry_view.dart';
import 'package:flash/firebase_options.dart';
import 'package:flash/view/home/home_view.dart';
import 'package:flash/view/login/login_view.dart';
import 'package:flash/view/register/register_view.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const Flash());
}

class Flash extends StatelessWidget {
  const Flash({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: EntryView.route,
      routes: {
        HomeView.route: (context) => HomeView(),
        EntryView.route: (context) => const EntryView(),
        LoginView.route: (context) => LoginView(),
        RegisterView.route: (context) => RegisterView(),
      },
    );
  }
}
