import 'package:flutter/material.dart';
class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  Icon icon;
   CustomTextField({
    super.key,
    required this.hint,
    required this.label,
    required this.controller,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Correctly referencing the controller
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixIcon: icon,
        border: const OutlineInputBorder(
        ),
      ),
    );
  }
}