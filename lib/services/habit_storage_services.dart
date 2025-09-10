import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:habits_tracker_app/constraint/app_constraint.dart';
import 'package:habits_tracker_app/model/weekly_habit_data.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HabitStorageService {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

/// use here weekly habit data //////
  static Future<List<WeeklyHabitData>> loadWeeklyData() async {
    try {
      final String? dataString = _prefs.getString(AppConstants.weeklyDataStorageKey);
      if (dataString != null) {
        final List<dynamic> jsonData = jsonDecode(dataString) as List<dynamic>;
        return jsonData.map((item) => WeeklyHabitData.fromJson(item)).toList();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading weekly data: $e');
      }
    }
    return [];
  }

//// use here save weekly data and weekly habit data///////
  static Future<void> saveWeeklyData(List<WeeklyHabitData> weeklyData) async {
    try {
      final List<Map<String, dynamic>> jsonData =
          weeklyData.map((data) => data.toJson()).toList();
      await _prefs.setString(AppConstants.weeklyDataStorageKey, jsonEncode(jsonData));
    } catch (e) {
      if (kDebugMode) {
        print('Error saving weekly data: $e');
      }
    }
  }

  static List<WeeklyHabitData> initializeWeekData() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    
    return List.generate(7, (index) {
      final date = startOfWeek.add(Duration(days: index));
      return WeeklyHabitData(
        weekday: AppConstants.weekdays[index],
        dayIndex: index,
        completionPercentage: 0,
        date: date,
        completedHabits: 0,
        totalHabits: AppConstants.sampleHabits.length,
        completedHabitNames: [],
      );
    });
  }
}