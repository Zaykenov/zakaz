import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zakaz_send/auth.dart';
import 'package:zakaz_send/screens/projectmanager_page.dart';
import 'package:zakaz_send/screens/translator_page.dart';

class LogIn extends StatefulWidget {
  final bool isTranslator;
  LogIn({super.key, required this.isTranslator});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _isPasswordObscured = true;

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword(bool isTranslator) async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        isTranslator: isTranslator,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> loginOrSignup(bool isLogin) {
    if (isLogin) {
      return signInWithEmailAndPassword();
    }
    return createUserWithEmailAndPassword(widget.isTranslator);
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed: () async {
        await loginOrSignup(isLogin);
        if (errorMessage!.isEmpty) {
          if (widget.isTranslator) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TranslatorPage()));
          } else {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProjectManagerPage()));
          }
        }
      },
      child: Text(
        isLogin ? 'Log in' : 'Register',
        style: TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity,
            48.0), // set minimum width to be the width of the parent container and height to 48.0
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        backgroundColor: Color(0xFF5E76E7),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        elevation: 0,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin = true;
                  });
                },
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                    if (isLogin)
                      Container(
                        height: 3,
                        width: double.infinity,
                        color: Color(0xFF5E76E7),
                      ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isLogin = false;
                  });
                },
                child: Column(
                  children: [
                    Text('Sign-up',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    if (!isLogin)
                      Container(
                        height: 3,
                        width: double.infinity,
                        color: Color(0xFF5E76E7),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controllerEmail,
                decoration: const InputDecoration(labelText: 'Email address'),
              ),
              const SizedBox(height: 50),
              TextField(
                obscureText: _isPasswordObscured,
                controller: _controllerPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                    child: Icon(
                      _isPasswordObscured
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                errorMessage == '' ? '' : '$errorMessage',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 150),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }
}
