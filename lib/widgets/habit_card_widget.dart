import 'package:flutter/material.dart';
import 'package:habits_tracker_app/model/habit_model.dart';

class HabitCardWidget extends StatelessWidget {

  /// here is we use habit model with card /////// 
  final HabitModel card;

  const HabitCardWidget({super.key, required this.card});
  
  //// here is code for icon data which showing in the home screen
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
    return InkWell(
      onTap: card.ontap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: card.backgroundColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: card.backgroundColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon instead of image
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getIconForCategory(card.title),
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(height: 12),
            
            // Title
            Text(
              card.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            // Habits count
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "${card.habits.length} habit${card.habits.length != 1 ? 's' : ''}",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}