// Extension to add copyWith method to HabitModel
import 'package:flutter/material.dart';
import 'package:habits_tracker_app/model/habit_model.dart';
import 'package:habits_tracker_app/model/individual_habit_model.dart';

extension HabitModelExtension on HabitModel {
  HabitModel copyWith({
    String? id,
    String? title,
    String? imagepath,
    Color? backgroundColor,
    VoidCallback? ontap,
    List<IndividualHabitModel>? habits,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      imagepath: imagepath ?? this.imagepath,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      ontap: ontap ?? this.ontap,
      habits: habits ?? this.habits,
    );
  }
}