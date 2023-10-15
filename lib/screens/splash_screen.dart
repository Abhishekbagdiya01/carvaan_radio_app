import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_radio/screens/home_screen.dart';
import 'package:flutter_radio/utils/const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 3000), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 242, 222),
      body: Center(
        child: Image.asset(APPLOGO),
      ),
    );
  }
}
