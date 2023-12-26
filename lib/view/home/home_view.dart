import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/view/home/widget/future_get.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
 const  HomeView({super.key, this.senderEmail});

  static const String route = 'HomeView';
  final String? senderEmail;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final smsController = TextEditingController();
  final chatsCollection = FirebaseFirestore.instance.collection('chats');
  Future<void> addMessage() async {
    // Call the user's CollectionReference to add a new user
    return await chatsCollection
        .add({
          'id': FirebaseAuth.instance.currentUser!.uid, // John Doe
          'sms': smsController.text, // Stokes and Sons
          'senderEmail': widget.senderEmail, // 42
        })
        .then((value) => log("User Added"))
        .catchError((error) => log("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home View'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetFutureSms(FirebaseAuth.instance.currentUser!.uid),
            const SizedBox(),
            Container(
              decoration: const BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.blue, width: 2))),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: smsController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: 'Type your message here...',
                          border: InputBorder.none),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      await addMessage();
                    },
                    child: const Text(
                      'Send',
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
