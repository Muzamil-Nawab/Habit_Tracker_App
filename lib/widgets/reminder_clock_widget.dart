import 'package:flutter/material.dart';
import 'package:habits_tracker_app/constraint/contraints.dart';

class ReminderClockWidget extends StatelessWidget {
  final String label;
 
  final TimeOfDay time;
  final bool isEnabled;
  final VoidCallback onTapTime;
  final ValueChanged<bool> onToggle;

  const ReminderClockWidget({
    required this.label,
    
    required this.time,
    required this.isEnabled,
    required this.onTapTime,
    required this.onToggle,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = time.format(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyle.remindertext),
        SizedBox(height: 15),
        Row(
          children: [
            InkWell(
              onTap: onTapTime,
              child: Text(
                formattedTime,
                style: TextStyle(
                  fontSize: 16,
                  //fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 180),
            Switch(
              value: isEnabled,
              onChanged: onToggle,
              activeColor: Colors.white, // Thumb color when ON
              activeTrackColor: Colors.deepPurple, // Track color when ON
              inactiveThumbColor: Colors.deepPurpleAccent, // Thumb color when OFF
              inactiveTrackColor: Colors.white, // Track color when OFF
            ),
          ],
        ),
      ],
    );
  }
}


