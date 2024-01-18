import 'package:flutter/material.dart';

class ModerationTicket extends StatefulWidget {
  const ModerationTicket({super.key});

  @override
  State<StatefulWidget> createState() => _ModerationTicketState();
}

class _ModerationTicketState extends State<ModerationTicket> {
  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
        aspectRatio: 1.2,
        child: Card(child: Center(child: Text('Moderation Ticket'))));
  }
}
