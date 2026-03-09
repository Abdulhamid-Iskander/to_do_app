import 'package:flutter/material.dart';

class CustomAddTaskField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? suffixIcon;
  final int maxLines;

  const CustomAddTaskField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white), 
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)), 
        filled: true,
        fillColor: Colors.pink[100]?.withOpacity(0.5),
        suffixIcon: suffixIcon != null ? Icon(suffixIcon, color: Colors.white) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white, width: 2), 
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      ),
    );
  }
}