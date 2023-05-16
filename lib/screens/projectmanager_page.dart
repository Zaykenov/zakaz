import 'package:firebase_auth/firebase_auth.dart';
import 'package:zakaz_send/auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'assignTask_page.dart';
import 'check_work.dart';

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
          'Project Manager',
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final docs = snapshot.data!.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;
                return Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      width: 320,
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        onTap: () {
                          data['available']
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AssignTask(
                                      userData: data,
                                    ),
                                  ),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CheckWork(
                                      userData: data,
                                    ),
                                  ),
                                );
                        },
                        leading: Stack(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
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
                            Positioned(
                              left: 0,
                              top: 0,
                              child: data['available']
                                  ? const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.green,
                                    )
                                  : const CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.red,
                                    ),
                            )
                          ],
                        ),
                        title: Text(
                          data['email'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        subtitle: data['available']
                            ? null
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Deadline date: ${data['deadline'].toDate().day.toString().padLeft(2, '0')}.${data['deadline'].toDate().month.toString().padLeft(2, '0')}.${data['deadline'].toDate().year.toString()}',
                                    style: const TextStyle(
                                        color: Color(0xFFEC95A8),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: data['result'].length /
                                        data['editText'].length,
                                    color: Color(0xFF33ED67),
                                    backgroundColor: const Color(0xFFF2F2F2),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                );
              },
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
