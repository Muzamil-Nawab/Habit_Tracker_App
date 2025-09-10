//import 'package:device_preview_plus/device_preview_plus.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:habits_tracker_app/onbourding_screen/onbourding_screen.dart';

void main() {
  runApp(
    // DevicePreview(
    // enabled: !kReleaseMode, // Enable only in debug mode
    // builder: (context) =>
    MyApp(), // Wrap your app
    //),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
