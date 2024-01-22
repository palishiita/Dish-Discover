import 'package:flutter/material.dart';

class Ticket extends ChangeNotifier {
  int? reportId;
  int? recipeId;
  String? violatorId; // NOTE: Usernames (strings) are primary keys
  String? issuerId;
  int? commentId;
  String? reason;
  bool accepted;

  Ticket(
      {this.reportId,
      this.recipeId,
      this.violatorId,
      this.issuerId,
      this.commentId,
      this.reason,
      this.accepted = false});
}
