import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      reportId: json['reportId'],
      recipeId: json['recipeId'],
      violatorId: json['violatorId'],
      issuerId: json['issuerId'],
      commentId: json['commentId'],
      reason: json['reason'],
      accepted: json['accepted'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reportId': reportId,
      'recipeId': recipeId,
      'violatorId': violatorId,
      'issuerId': issuerId,
      'commentId': commentId,
      'reason': reason,
      'accepted': accepted,
    };
  }

  Map<String, dynamic>? getIdentifierAndViolator() {
    if (commentId != null) {
      return {'identifier': commentId, 'violatorId': violatorId};
    } else if (recipeId != null) {
      return {'identifier': recipeId, 'violatorId': violatorId};
    } else {
      return null;
    }
  }

  static Future<void> addTicket(Ticket ticket) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/tickets'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ticket.toJson()),
    );

    if (response.statusCode == 201) {
      print('Ticket added successfully');
    } else {
      throw Exception(
          'Failed to add ticket, status code: ${response.statusCode}');
    }
  }

  static Future<List<Ticket>> getTickets() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/tickets'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['tickets'];
      return data.map((item) => Ticket.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load tickets, status code: ${response.statusCode}');
    }
  }
}
