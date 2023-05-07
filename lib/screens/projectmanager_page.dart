import 'package:firebase_auth/firebase_auth.dart';
import 'package:zakaz_send/auth.dart';
import 'package:flutter/material.dart';

class ProjectManagerPage extends StatelessWidget {
  ProjectManagerPage({Key? key}) : super(key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut(BuildContext context) async {
    await Auth().signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Manager'),
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
              onPressed: () => signOut(context),
              child: const Text('sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
