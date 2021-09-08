import 'package:flutter/material.dart';
import 'package:whatsapp/presentation/screens/splash_screen.dart';
import 'package:whatsapp/presentation/widgets/theme/style.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp',
      theme: ThemeData(primaryColor: lightPrimaryColor),
      home: SplashScreen(),
    );
  }
}
