import 'dart:async';
import 'package:dotcom/logIn/logIn.dart';
import 'package:dotcom/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () async {
      final prefs = await SharedPreferences.getInstance();

      if (prefs.getBool('userLoggedIn') == true) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MyApp()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const LogInPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CLICK',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Image(
                        width: 220,
                        image: AssetImage('lib/images/11.png'),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
