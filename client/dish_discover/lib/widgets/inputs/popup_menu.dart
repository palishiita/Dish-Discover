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
  final void Function()? onPressed1;
  final PopupMenuAction action2;
  final void Function()? onPressed2;

  const PopupMenu(
      {super.key,
      required this.action1,
      required this.onPressed1,
      required this.action2,
      required this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuAction>(
        initialValue: null,
        onSelected: (PopupMenuAction action) {},
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<PopupMenuAction>>[
              PopupMenuItem<PopupMenuAction>(
                value: action1,
                onTap: onPressed1,
                child: Text(action1.name, overflow: TextOverflow.fade),
              ),
              PopupMenuItem<PopupMenuAction>(
                value: action2,
                onTap: onPressed2,
                child: Text(action2.name, overflow: TextOverflow.fade),
              )
            ]);
  }
}
