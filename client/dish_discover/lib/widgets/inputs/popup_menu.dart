import 'package:flutter/material.dart';

enum PopupMenuAction {
  share(name: 'Share'),
  edit(name: 'Edit'),
  report(name: 'Report'),
  ban(name: 'Ban'),
  delete(name: 'Delete'),
  boost(name: 'Boost visibility');

  const PopupMenuAction({required this.name});
  final String name;
}

class PopupMenu extends StatelessWidget {
  final PopupMenuAction action1;
  final PopupMenuAction action2;

  const PopupMenu({super.key, required this.action1, required this.action2});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuAction>(
        initialValue: null,
        onSelected: (PopupMenuAction action) {},
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<PopupMenuAction>>[
              PopupMenuItem<PopupMenuAction>(
                value: action1,
                child: Text(action1.name),
              ),
              PopupMenuItem<PopupMenuAction>(
                value: action2,
                child: Text(action2.name),
              )
            ]);
  }
}
