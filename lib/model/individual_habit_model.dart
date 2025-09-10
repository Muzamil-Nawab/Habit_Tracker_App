import 'package:flutter/material.dart';

// Individual habit within a card
class IndividualHabitModel {
  final String id;
  final String title;
  final String description;
  final String goal; // Daily, Weekly, Monthly
  final TimeOfDay? reminderTime;
  final bool isReminderEnabled;
  final DateTime createdAt;
  
  IndividualHabitModel({
    required this.id,
    required this.title,
    required this.description,
    required this.goal,
    this.reminderTime,
    this.isReminderEnabled = false,
    required this.createdAt,
  });
}

