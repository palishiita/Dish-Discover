import 'package:dish_discover/widgets/pages/view_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';
import '../../entities/ticket.dart';
import '../../entities/user.dart';
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
    String contentType = ticket.violatorId != null
        ? 'User'
        : ticket.commentId != null
            ? 'Comment'
            : 'Recipe';

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: AspectRatio(
            aspectRatio: 1.2,
            child: Card(
                child: Column(children: [
              ListTile(
                  leading: UserAvatar(
                      image: null, // TODO get User avatar
                      diameter: 30,
                      userProvider: ChangeNotifierProvider<User>((ref) =>
                          User(username: ticket.issuerId, isModerator: false))),
                  title: Text('Ticket #${ticket.reportId}'),
                  subtitle: GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UserPage(
                              userProvider: ChangeNotifierProvider<User>(
                                  (ref) => User(
                                      username: ticket.issuerId,
                                      isModerator: false))))),
                      child: Text(ticket.issuerId ?? 'null')),
                  trailing: AspectRatio(
                      aspectRatio: 1.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                // TODO release ticket back into queue
                              }),
                          IconButton(
                              padding: const EdgeInsets.only(left: 20.0),
                              icon: Icon(ticket.accepted
                                  ? Icons.delete
                                  : Icons.check_rounded),
                              onPressed: ticket.accepted
                                  ? () {
                                      // TODO finish (delete) ticket
                                    }
                                  : () {
                                      // TODO accept ticket
                                    })
                        ],
                      ))),
              const Divider(height: 1.0),
              Expanded(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(ticket.reason ?? '[Reason]')))),
              const Divider(height: 1.0),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: Row(children: [
                    Expanded(child: Text("${ticket.issuerId}:$contentType")),
                    IconButton(
                        icon: const Icon(Icons.arrow_right_alt_rounded),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => contentType == 'User'
                                  ? UserPage(
                                      userProvider:
                                          ChangeNotifierProvider<User>((ref) =>
                                              User(
                                                  username: ticket.violatorId,
                                                  isModerator: false)))
                                  : ViewRecipePage(
                                      recipeProvider:
                                          ChangeNotifierProvider<Recipe>(
                                              (ref) => Recipe(
                                                  id: ticket.recipeId,
                                                  title:
                                                      'Bad recipe/comment')))));
                        })
                  ]))
            ]))));
  }
}
