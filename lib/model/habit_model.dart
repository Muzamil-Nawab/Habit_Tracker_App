// Updated HabitModel to include individual habits
import 'package:flutter/material.dart';
import 'package:habits_tracker_app/model/individual_habit_model.dart';

class HabitModel {
  final String id;
  final String title;
  final String imagepath;
  final Color backgroundColor;
  final VoidCallback? ontap;
  final List<IndividualHabitModel> habits; // List of habits within this card

  HabitModel({
    required this.id,
    required this.title,
    required this.imagepath,
    required this.ontap,
    required this.backgroundColor,
    this.habits = const [],
  });

  // Method to add a habit to this card
  HabitModel addHabit(IndividualHabitModel habit) {
    return HabitModel(
      id: id,
      title: title,
      imagepath: imagepath,
      ontap: ontap,
      backgroundColor: backgroundColor,
      habits: [...habits, habit],
    );
  }

  // Method to remove a habit from this card
  HabitModel removeHabit(String habitId) {
    return HabitModel(
      id: id,
      title: title,
      imagepath: imagepath,
      ontap: ontap,
      backgroundColor: backgroundColor,
      habits: habits.where((habit) => habit.id != habitId).toList(),
    );
  }
}
