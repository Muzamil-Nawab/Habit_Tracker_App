import 'package:flutter/material.dart';

class AppConstants {
  
  // Colors
  static const Color backgroundColor = Color(0xFF0D1421);
  static const Color cardBackgroundColor = Color(0xFF1F2442);
  static const Color primaryGradientStart = Color(0xFF4F46E5);
  static const Color primaryGradientEnd = Color(0xFF06B6D4);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF68737D);
  static const Color textLight = Colors.white70;





  // Sample habits list code
  static const List<String> sampleHabits = [
    'Drink 8 glasses of water',
    'Exercise for 30 minutes',
    'Read for 20 minutes',
    'Meditate for 10 minutes',
    'Write in journal',
    'Take vitamins',
    'Clean workspace',
  ];

  // Weekdays
  static const List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  // Storage keys
  static const String weeklyDataStorageKey = 'weekly_habit_data';

  // Animation durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 1500);
  static const Duration snackBarDuration = Duration(seconds: 3);

  // Chart configuration
  static const double chartHeight = 300.0;
  static const double chartBarWidth = 4.0;
  static const double chartDotRadius = 8.0;
  static const double chartGridInterval = 25.0;

  // Streak threshold
  static const double streakThreshold = 70.0; // 70% completion for streak
}