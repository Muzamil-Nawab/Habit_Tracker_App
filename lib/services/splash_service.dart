import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habits_tracker_app/Auth/login_screen.dart';

class SplashService {
  void isLogin(BuildContext context) {
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}