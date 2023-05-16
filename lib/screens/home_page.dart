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
          backgroundColor: Color(0xFF5E76E7),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80.0,
                    height: 80.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.e_mobiledata,
                        color: Color(0xFF5E76E7),
                        size: 40.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text('Trust your translations to us this is branch and also',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      )),
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
                                ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.manage_accounts,
                          color: Color(0xFF5E76E7),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Project Manager',
                          style: TextStyle(
                            color: Color(0xFF5E76E7),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
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
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.translate,
                          color: Color(0xFF5E76E7),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          'Translator',
                          style: TextStyle(
                            color: Color(0xFF5E76E7),
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
