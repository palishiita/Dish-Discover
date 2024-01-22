import 'package:flutter/cupertino.dart';

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
