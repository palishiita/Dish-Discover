import 'package:flutter/material.dart';

class TagInputBox extends StatelessWidget {
  final String hint;
  final IconButton action;
  const TagInputBox({super.key, required this.hint, required this.action});

  @override
  Widget build(BuildContext context) {
    return TextField(
        autocorrect: false,
        obscureText: hint == 'Password',
        enableSuggestions: true,
        decoration: InputDecoration(
            suffixIcon: action,
            hintText: hint,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)))));
  }
}
