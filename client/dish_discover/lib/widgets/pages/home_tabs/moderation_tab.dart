import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../entities/app_state.dart';
import '../../../entities/ticket.dart';
import '../../display/tab_title.dart';
import '../../display_with_input/moderation_ticket.dart';
import '../../display_with_input/tag_management_box.dart';

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
          child: ListView(children: [
        ModerationTicket(
            ticketProvider: ChangeNotifierProvider<Ticket>((ref) => Ticket(
                reportId: 123,
                violatorId: AppState.currentUser!.username,
                issuerId: AppState.currentUser!.username,
                reason: '[Reason]'))),
        const TagManagementBox()
      ]))
    ]);
  }
}
