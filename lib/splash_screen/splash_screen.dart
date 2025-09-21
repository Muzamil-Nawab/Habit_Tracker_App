import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habits_tracker_app/onbourding_screen/onbourding_screen.dart';
import 'package:habits_tracker_app/services/splash_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashService splashScreen = SplashService();
  
  @override
void initState() {
  super.initState();

  splashScreen.isLogin(context);

  WidgetsBinding.instance.addPostFrameCallback((_) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
          child: Image(image: AssetImage("lib/assets/Logo_pic.png")),
        ),
      ),
    );
  }
}
