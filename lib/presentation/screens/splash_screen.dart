import 'dart:async';

import 'package:flutter/material.dart';
import 'package:whatsapp/presentation/screens/welcome_screen.dart';
import 'package:whatsapp/presentation/widgets/theme/style.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => WelcomeScreen(),
        ),
        (route) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Center(
            child: Image.asset(
              "assets/splash_icon.png",
              height: 100,
            ),
          ),
          Positioned(
              bottom: 50,
              child: Text(
                "FACEBOOK",
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              )),
          Positioned(
              bottom: 70,
              child: Text(
                "from",
                style: TextStyle(
                  color: Colors.black38,
                ),
              )),
        ],
      ),
    );
  }
}
