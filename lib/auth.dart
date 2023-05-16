import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    bool available = true,
    String editText = '',
    String result = '',
    bool isTranslator = true,
  }) async {
    // create user in Firebase Auth
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // get the user ID and create the Firestore document
    String userId = currentUser!.uid;
    if (isTranslator) {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'uid': userId,
        'email': email,
        'available': available,
        'editText': editText,
        'result': result,
        'expectedDate': DateTime.now(),
        'deadline': DateTime.now(),
      });
    } else {
      await FirebaseFirestore.instance.collection('projects').doc(userId).set({
        'email': email,
      });
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
