import 'package:flutter/material.dart';

class ModerationTicket extends StatefulWidget {
  const ModerationTicket({super.key});

  @override
  State<StatefulWidget> createState() => _ModerationTicketState();
}

class _ModerationTicketState extends State<ModerationTicket> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: AspectRatio(
            aspectRatio: 1.2,
            child: Card(child: Center(child: Text('Moderation Ticket')))));
  }
}
