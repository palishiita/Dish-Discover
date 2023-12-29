import 'package:flutter/material.dart';

class TextInputBox extends StatelessWidget {
  final String hint;
  final bool obscure;
  const TextInputBox({super.key, required this.hint, this.obscure = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
        autocorrect: false,
        obscureText: obscure,
        decoration: InputDecoration(
            hintText: hint,
            constraints: const BoxConstraints.tightFor(height: 40, width: 200),
            contentPadding: const EdgeInsets.all(10),
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)))));
  }
}
