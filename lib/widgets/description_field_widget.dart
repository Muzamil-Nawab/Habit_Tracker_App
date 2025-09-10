import 'package:flutter/material.dart';

class DescriptionFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final String? hintText;

  const DescriptionFieldWidget({
    required this.label,
    required this.controller,
    this.maxLines = 5,
    this.hintText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText ?? 'Enter description...',
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }
}
