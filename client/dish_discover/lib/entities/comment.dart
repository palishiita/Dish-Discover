import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

class Comment extends ChangeNotifier {
  int? commentId;
  int? authorId;
  int? recipeId;
  String? content;

  Comment({
    this.authorId,
    this.recipeId,
    this.commentId,
    this.content
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      commentId: json['commentId'],
      authorId: json['authorId'],
      recipeId: json['recipeId'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'authorId': authorId,
      'recipeId': recipeId,
      'content': content,
    };
  }

  Future<void> addComment(Comment comment) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/comments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(comment.toJson()),
    );

    if (response.statusCode == 201) {
      print('Comment added successfully');
    } else {
      throw Exception('Failed to add comment, status code: ${response.statusCode}');
    }
  }

  Future<List<Comment>> getComments(int recipeId) async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/recipes/$recipeId/comments'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['comments'];
      return data.map((item) => Comment.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load comments, status code: ${response.statusCode}');
    }
  }
}