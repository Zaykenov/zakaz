import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zakaz_send/auth.dart';
import 'package:flutter/material.dart';

class TranslatorPage extends StatelessWidget {
  TranslatorPage({super.key});

  final User? user = Auth().currentUser;

  Future<void> signOut(BuildContext context) async {
    await Auth().signOut();
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }

  void updateFirestore(String text) async {
    final userRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    await userRef.update({
      'result': text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Translator',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () => signOut(context),
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ))
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: data['available']
                      ? Column(
                          children: const <Widget>[
                            SizedBox(
                              height: 270,
                            ),
                            Text(
                              'No Active Tasks',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(15),
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    'https://static.vecteezy.com/system/resources/thumbnails/017/287/197/small/smart-young-man-sit-on-table-work-on-laptop-with-textbooks-smiling-male-busy-study-on-computer-at-home-office-technology-and-education-illustration-vector.jpg',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              '${data['email']}',
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 40),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Edit Text',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(data['editText']),
                              ),
                            ),
                            const SizedBox(height: 25),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Translation',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller:
                                  TextEditingController(text: data['result']),
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                              ),
                              maxLines: null,
                              onChanged: (text) => updateFirestore(text),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
