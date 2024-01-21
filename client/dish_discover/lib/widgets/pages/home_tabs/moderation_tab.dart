import 'package:dish_discover/widgets/inputs/moderation_ticket.dart';
import 'package:dish_discover/widgets/inputs/tag_management_box.dart';
import 'package:flutter/material.dart';

import '../../display/tab_title.dart';

class ModerationTab extends StatefulWidget {
  const ModerationTab({super.key});

  @override
  State<StatefulWidget> createState() => _ModerationTabState();
}

class _ModerationTabState extends State<ModerationTab> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TabTitle(title: 'Moderation'),
      Expanded(
          child: ListView(
              children: const [ModerationTicket(), TagManagementBox()]))
    ]);
  }
}
