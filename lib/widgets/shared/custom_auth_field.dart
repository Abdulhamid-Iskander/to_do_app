import 'package:flutter/material.dart';

class CustomAuthField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final bool isPassword;

  const CustomAuthField({
    super.key,
    required this.controller,
    required this.label,
    this.isPassword = false,
  });

  @override
  State<CustomAuthField> createState() => _CustomAuthFieldState();
}

class _CustomAuthFieldState extends State<CustomAuthField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? isObscure : false,
      decoration: InputDecoration(
        labelText: widget.label,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  isObscure ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
    );
  }
}