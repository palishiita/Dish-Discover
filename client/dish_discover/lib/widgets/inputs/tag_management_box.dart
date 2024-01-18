import 'package:flutter/material.dart';

class TagManagementBox extends StatefulWidget {
  const TagManagementBox({super.key});

  @override
  State<StatefulWidget> createState() => _TagManagementBoxState();
}

class _TagManagementBoxState extends State<TagManagementBox> {
  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
        aspectRatio: 0.6,
        child: Card(child: Center(child: Text('Tag Management Box'))));
  }
}
