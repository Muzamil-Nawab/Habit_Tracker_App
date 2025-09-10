import 'package:flutter/material.dart';
import 'package:habits_tracker_app/model/habit_model.dart';
import 'package:habits_tracker_app/model/individual_habit_model.dart';

class CardDetailScreen extends StatefulWidget {
  // call habit model but in a constructor /////
  final HabitModel card;
  final Function(HabitModel) onCardUpdated;

  const CardDetailScreen({
    super.key,
    required this.card,
    required this.onCardUpdated,
  });

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  late HabitModel currentCard;

  @override
  void initState() {
    super.initState();
    currentCard = widget.card;
  }

  //// function for delete habit
  void _deleteHabit(String habitId) {
    setState(() {
      currentCard = currentCard.removeHabit(habitId);
    });
    widget.onCardUpdated(currentCard);
  }

  /// function for delete the habit dialoge which one you craete in new habit screen and add in a perticular habit dialoge /////
  void _showDeleteDialog(IndividualHabitModel habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F2442),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Delete Habit",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        content: Text(
          "Are you sure you want to delete '${habit.title}'?",
          // ignore: deprecated_member_use
          style: TextStyle(color: Colors.white.withOpacity(0.8)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              // ignore: deprecated_member_use
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteHabit(habit.id);
            },
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  /// this is code for categories showing on home screen ///////
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
        title: Text(
          currentCard.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header section
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: currentCard.backgroundColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: currentCard.backgroundColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    _getIconForCategory(currentCard.title),
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentCard.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${currentCard.habits.length} habits",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Habits list
          Expanded(
            child: currentCard.habits.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 80,
                          // ignore: deprecated_member_use
                          color: Colors.white.withOpacity(0.3),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No habits yet",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Add your first habit to get started!",
                          style: TextStyle(
                            fontSize: 16,
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: currentCard.habits.length,
                    itemBuilder: (context, index) {
                      final habit = currentCard.habits[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2442),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            // ignore: deprecated_member_use
                            color: Colors.white.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(16),
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              // ignore: deprecated_member_use
                              color: currentCard.backgroundColor.withOpacity(
                                0.2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              Icons.check_circle_outline,
                              color: currentCard.backgroundColor,
                            ),
                          ),
                          title: Text(
                            habit.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (habit.description.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Text(
                                  habit.description,
                                  style: TextStyle(
                                    // ignore: deprecated_member_use
                                    color: Colors.white.withOpacity(0.7),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      // ignore: deprecated_member_use
                                      color: currentCard.backgroundColor
                                          // ignore: deprecated_member_use
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      habit.goal,
                                      style: TextStyle(
                                        color: currentCard.backgroundColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  if (habit.isReminderEnabled &&
                                      habit.reminderTime != null) ...[
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        // ignore: deprecated_member_use
                                        color: Colors.blue.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.alarm,
                                            size: 12,
                                            color: Colors.blue,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            habit.reminderTime!.format(context),
                                            style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            onPressed: () => _showDeleteDialog(habit),
                            icon: Icon(
                              Icons.delete_outline,
                              // ignore: deprecated_member_use
                              color: Colors.red.withOpacity(0.7),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
