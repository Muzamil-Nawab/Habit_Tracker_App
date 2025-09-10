import 'package:flutter/material.dart';
import 'package:habits_tracker_app/constraint/app_constraint.dart';
import 'package:habits_tracker_app/model/weekly_habit_data.dart';

class HabitDetailedDialogWidget extends StatelessWidget {
  final WeeklyHabitData data;

  const HabitDetailedDialogWidget({super.key, required this.data});

/// widget for checking complete or not habit /////
  Widget _buildHabitItem({required String habit, required bool isCompleted}) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 4),
      child: Row(
        children: [
          Icon(
            isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isCompleted ? Colors.green : Colors.orange,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              habit,
              style: TextStyle(
                color: isCompleted ? Colors.white : Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppConstants.cardBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: Colors.blueAccent,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  '${data.weekday} Progress',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${data.completedHabits}/${data.totalHabits} habits completed (${data.completionPercentage.toStringAsFixed(1)}%)',
              style: const TextStyle(
                fontSize: 14,
                color: AppConstants.textLight,
              ),
            ),
            const SizedBox(height: 20),

            // Completed Habits
            if (data.completedHabitNames.isNotEmpty) ...[
              const Text(
                '✅ Completed Habits:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.greenAccent,
                ),
              ),
              const SizedBox(height: 8),
              ...data.completedHabitNames.map(
                (habit) => _buildHabitItem(habit: habit, isCompleted: true),
              ),
              const SizedBox(height: 16),
            ],

            // Pending Habits
            if (data.completedHabitNames.length <
                AppConstants.sampleHabits.length) ...[
              const Text(
                '⏳ Pending Habits:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.orangeAccent,
                ),
              ),
              const SizedBox(height: 8),
              ...AppConstants.sampleHabits
                  .where((habit) => !data.completedHabitNames.contains(habit))
                  .map(
                    (habit) =>
                        _buildHabitItem(habit: habit, isCompleted: false),
                  ),
            ],

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  
}
