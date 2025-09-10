import 'package:flutter/material.dart';
import 'package:habits_tracker_app/model/habit_model.dart';
import 'package:habits_tracker_app/constraint/contraints.dart';
import 'package:habits_tracker_app/model/individual_habit_model.dart';
import 'package:habits_tracker_app/widgets/description_field_widget.dart';
import 'package:habits_tracker_app/widgets/reminder_clock_widget.dart';

class NewHabitsScreen extends StatefulWidget {
  final List<HabitModel> cards;
  final Function(String cardId, IndividualHabitModel habit) onHabitSaved;

  const NewHabitsScreen({
    super.key,
    required this.cards,
    required this.onHabitSaved,
  });

  @override
  State<NewHabitsScreen> createState() => _NewHabitsScreenState();
}

class _NewHabitsScreenState extends State<NewHabitsScreen> {
  final TextEditingController habitTitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  /// code for reminder clock /////
  TimeOfDay selectedTime = TimeOfDay(hour: 8, minute: 0);
  bool isReminderEnabled = false;
  String selectedGoal = "Daily"; // Default goal

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  void _toggleReminder(bool value) {
    setState(() {
      isReminderEnabled = value;
    });
  }

  void _selectGoal(String goal) {
    setState(() {
      selectedGoal = goal;
    });
  }

  void _clearAllFields() {
    setState(() {
      habitTitleController.clear();
      descriptionController.clear();
      selectedTime = TimeOfDay(hour: 8, minute: 0);
      isReminderEnabled = false;
      selectedGoal = "Daily";
    });
  }

  void _showCardSelectionDialog() {
    if (habitTitleController.text.trim().isEmpty) {
      _showSnackBar("Please enter a habit title");
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F2442),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Choose Category",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.cards.length,
            itemBuilder: (context, index) {
              final card = widget.cards[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: card.backgroundColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    // ignore: deprecated_member_use
                    color: card.backgroundColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: card.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      _getIconForCategory(card.title),
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    card.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    "${card.habits.length} habits",
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: card.backgroundColor,
                    size: 16,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _saveHabit(card.id);
                  },
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _saveHabit(String cardId) {
    final habit = IndividualHabitModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: habitTitleController.text.trim(),
      description: descriptionController.text.trim(),
      goal: selectedGoal,
      reminderTime: isReminderEnabled ? selectedTime : null,
      isReminderEnabled: isReminderEnabled,
      createdAt: DateTime.now(),
    );

    widget.onHabitSaved(cardId, habit);
    _clearAllFields();
    _showSnackBar("Habit saved successfully!");

    // Navigate back to home screen
    Navigator.pop(context);
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF4F46E5),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  /// code for goal button //////
  Widget _buildGoalButton(String goal) {
    final isSelected = selectedGoal == goal;
    return GestureDetector(
      onTap: () => _selectGoal(goal),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4F46E5) : const Color(0xFF1F2442),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            // ignore: deprecated_member_use
            color: isSelected
                ? const Color(0xFF4F46E5)
                : Colors.white.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Text(
          goal,
          style: TextStyle(
            // ignore: deprecated_member_use
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.7),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// code for action button /////
  Widget _buildActionButton({
    required String text,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }

  //// code for icon showing on the card in the home screen ////////
  IconData _getIconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'reading books':
        return Icons.menu_book;
      case 'daily exercise':
        return Icons.fitness_center;
      case 'drinking water':
        return Icons.local_drink;
      case 'healthy eating':
        return Icons.restaurant;
      default:
        return Icons.check_circle_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF0D1421),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F2442),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        title: const Text(
          "New Habit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "Create New Habit",
                  style: AppStyle.newhabittext.copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              DescriptionFieldWidget(
                label: 'Habit Title',
                controller: habitTitleController,
                hintText: 'Enter habit title',
                maxLines: 1,
              ),
              const SizedBox(height: 10),
              DescriptionFieldWidget(
                label: 'Description',
                controller: descriptionController,
                hintText: 'Enter habit description (optional)',
                maxLines: 4,
              ),
              const SizedBox(height: 15),

              Text(
                "Goal",
                style: AppStyle.goaltext.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 15),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildGoalButton("Daily"),
                  const SizedBox(width: 8),
                  _buildGoalButton("Weekly"),
                  const SizedBox(width: 8),
                  _buildGoalButton("Monthly"),
                ],
              ),
              const SizedBox(height: 20),

              // code for reminder clock /////
              ReminderClockWidget(
                label: "Reminder",
                time: selectedTime,
                isEnabled: isReminderEnabled,
                onTapTime: _pickTime,
                onToggle: _toggleReminder,
              ),
              const SizedBox(height: 30),

              // Action buttons
              Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      text: "Cancel",
                      onPressed: () {
                        _clearAllFields();
                        _showSnackBar("All fields cleared!");
                      },
                      // ignore: deprecated_member_use
                      backgroundColor: Colors.red.withOpacity(0.2),
                      textColor: Colors.red,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildActionButton(
                      text: "Save",
                      onPressed: _showCardSelectionDialog,
                      backgroundColor: const Color(0xFF4F46E5),
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
