import 'package:dish_discover/entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Ticket {
  int? reportId;
  int? recipeId;
  int? violatorId;
  int? issuerId;
  int? commentId;
  String? reason;

  Ticket({
    this.reportId,
    this.recipeId,
    this.violatorId,
    this.issuerId,
    this.commentId,
    this.reason,
  });
}

// class Ticket extends ChangeNotifier {
//   final int id;
//   final User reporter;
//   final String contentType;
//   final String reason;
//   final ChangeNotifierProvider<ChangeNotifier> link;
//   bool accepted;

//   Ticket(this.reporter, this.id, this.contentType, this.reason, this.link,
//       {this.accepted = false});