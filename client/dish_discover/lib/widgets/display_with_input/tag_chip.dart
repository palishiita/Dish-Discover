import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String tag;

  const TagChip({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Chip(
        label: Text(tag),
        deleteIcon: const Icon(Icons.close_sharp),
        onDeleted: () {});
  }
}
