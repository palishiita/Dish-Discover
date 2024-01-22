
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
}