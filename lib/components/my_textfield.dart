import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
  final String text;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;

  const MyTextfield({
    super.key,
    required this.text,
    required this.obscureText,
    required this.textInputType,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade600),
          borderRadius: BorderRadius.circular(10),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(10),
        ),

        hintText: text,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        fillColor: Colors.grey.shade200,
        filled: true,
      ),
      
      obscureText: obscureText,
      keyboardType: textInputType,
      controller: controller,
    );
  }
}
