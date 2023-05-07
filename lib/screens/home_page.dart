import 'package:flutter/material.dart';
import 'package:zakaz_send/auth.dart';
import 'package:zakaz_send/screens/login_signup.dart';
import 'package:zakaz_send/screens/translator_page.dart';
import 'projectmanager_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome to my app!',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => snapshot.hasData
                              ? ProjectManagerPage()
                              : LogIn(
                                  isTranslator: false,
                                )),
                    );
                  },
                  child: Text('Project Manager'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => snapshot.hasData
                              ? TranslatorPage()
                              : LogIn(
                                  isTranslator: true,
                                )),
                    );
                  },
                  child: Text('Translator'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
