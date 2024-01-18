import 'package:dish_discover/widgets/inputs/moderation_ticket.dart';
import 'package:dish_discover/widgets/inputs/tag_management_box.dart';
import 'package:flutter/material.dart';

import '../../small/tab_title.dart';

class ModerationTab extends StatefulWidget {
  const ModerationTab({super.key});

  @override
  State<StatefulWidget> createState() => _ModerationTabState();
}

class _ModerationTabState extends State<ModerationTab> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Column(children: [
      TabTitle(title: 'Moderation'),
      Padding(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ModerationTicket(), TagManagementBox()]))
    ]));
  }
}
