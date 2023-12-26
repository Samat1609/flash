import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetFutureSms extends StatelessWidget {
  final String documentId;

  GetFutureSms(this.documentId);

  @override
  Widget build(BuildContext context) {
    CollectionReference chats = FirebaseFirestore.instance.collection('chats');

    return FutureBuilder<DocumentSnapshot>(
      future: chats.doc(documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Text("Full Name: ${data['full_name']} ${data['last_name']}");
        }

        return Text("loading");
      },
    );
  }
}
