import 'package:flutter/material.dart';
import 'package:habits_tracker_app/constraint/contraints.dart';

/// A reusable primary button with configurable text, action, and styling.
class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry margin;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.height = 48,
    this.borderRadius = 13,
    this.margin = const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: height,
      margin: margin,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: textColor ?? Colors.white,
          backgroundColor: backgroundColor ?? AppStyle.primaryGreen,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: theme.textTheme.labelLarge?.copyWith(
            color: textColor ?? Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
