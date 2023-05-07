import 'package:firebase_auth/firebase_auth.dart';
import 'package:zakaz_send/auth.dart';
import 'package:flutter/material.dart';

class TranslatorPage extends StatelessWidget {
  TranslatorPage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translator Page'),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(user?.email ?? 'User email'),
            ElevatedButton(
              onPressed: signOut,
              child: const Text('sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
