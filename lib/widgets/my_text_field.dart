import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.hintText,
    
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
          obscureText: obscureText,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,hintStyle: TextStyle(color: Colors.white),
            filled: false,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 18,
              horizontal: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
        );
      
    
  }
}
