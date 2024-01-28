import 'package:dish_discover/widgets/pages/view_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/ticket.dart';
import '../display/user_avatar.dart';
import '../pages/user.dart';

class ModerationTicket extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<Ticket> ticketProvider;
  const ModerationTicket({super.key, required this.ticketProvider});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ModerationTicketState();
}

class _ModerationTicketState extends ConsumerState<ModerationTicket> {
  @override
  Widget build(BuildContext context) {
    Ticket ticket = ref.watch(widget.ticketProvider);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: AspectRatio(
            aspectRatio: 1.2,
            child: Card(
                child: Column(children: [
              ListTile(
                  dense: false,
                  leading: UserAvatar(
                      username: ticket.issuerId,
                      image: null, // TODO get User avatar
                      diameter: 30),
                  title: Text('Ticket #${ticket.reportId}',
                      softWrap: true, overflow: TextOverflow.fade),
                  subtitle: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UserPage(username: ticket.issuerId))),
                      child: Text(ticket.issuerId,
                          softWrap: true, overflow: TextOverflow.fade)),
                  trailing: AspectRatio(
                      aspectRatio: 2.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                // TODO release ticket back into queue
                              }),
                          IconButton(
                              icon: Icon(ticket.accepted
                                  ? Icons.delete
                                  : Icons.check_rounded),
                              onPressed: ticket.accepted
                                  ? () {
                                      // TODO finish (delete) ticket
                                    }
                                  : () {
                                      // TODO accept ticket
                                      ticket.accepted = true;
                                    })
                        ],
                      ))),
              const Divider(height: 1.0),
              Expanded(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(ticket.reason,
                              softWrap: true, overflow: TextOverflow.fade)))),
              const Divider(height: 1.0),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: Row(children: [
                    Expanded(
                        child: Text(
                            "${ticket.issuerId}:${ticket.violatorId != null ? 'User' : ticket.commentId != null ? 'Comment' : 'Recipe'}",
                            softWrap: true,
                            overflow: TextOverflow.fade)),
                    IconButton(
                        icon: const Icon(Icons.arrow_right_alt_rounded),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ticket.violatorId != null
                                  ? UserPage(username: ticket.violatorId!)
                                  : ViewRecipePage(
                                      recipeId: ticket.recipeId!)));
                        })
                  ]))
            ]))));
  }
}
