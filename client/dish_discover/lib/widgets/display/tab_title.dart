import 'package:flutter/material.dart';

class TabTitle extends StatelessWidget {
  final String title;

  /// Padded text with context's titleLarge text style.
  const TabTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Text(title,
            softWrap: true,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium));
  }
}
