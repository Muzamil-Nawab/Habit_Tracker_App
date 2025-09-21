import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
   final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData icon;
  final String? Function(String?)? validator; // ✅ Added validator
  
   const MyTextField({
    super.key,
    
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.icon, this.validator,
  });
  

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
          obscureText: obscureText,
          keyboardType: keyboardType,
          controller: controller,
          validator: validator,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(icon,color: Colors.white,) ,
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
