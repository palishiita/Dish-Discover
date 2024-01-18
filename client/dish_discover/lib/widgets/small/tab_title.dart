import 'package:flutter/material.dart';

class TabTitle extends StatelessWidget {
  final String title;

  /// Padded text with context's titleLarge text style.
  const TabTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge));
  }
}
