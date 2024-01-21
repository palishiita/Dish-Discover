import 'package:dish_discover/entities/tag.dart';
import 'package:dish_discover/entities/user.dart';
import 'package:flutter/cupertino.dart';

class Recipe extends ChangeNotifier {
  User? author;
  String? title;
  DateTime? publicationDate;
  String? description;
  String? steps;
  Image? coverImage;
  List<Ingredient>? ingredients;
  List<Tag>? tags;
  List<Comment>? comments;
  bool? isBoosted;

  Recipe(
      {this.author,
      this.title,
      this.publicationDate,
      this.description,
      this.steps,
      this.coverImage,
      this.ingredients,
      this.tags,
      this.comments,
      this.isBoosted});

  void editRecipe(
      {String? title,
      String? description,
      String? steps,
      Image? coverImage,
      List<Ingredient>? ingredients,
      List<Tag>? tags}) {
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.steps = steps ?? this.steps;
    this.coverImage = coverImage ?? this.coverImage;
    this.ingredients?.addAll(ingredients as Iterable<Ingredient>);
    this.tags?.addAll(tags as Iterable<Tag>);
  }
}

class Comment {
  User? author;
  Recipe? recipe;
  DateTime? publicationDate;
  String? content;

  Comment(this.author, this.recipe, this.publicationDate, this.content);

  void editComment(String? content) {
    this.content = content ?? this.content;
  }

  void deleteComment(Comment comment) {
    if (author!.addedComments!.contains(comment)) {
      author?.addedComments?.remove(comment);
    }
  }
}

class Ingredient {
  String? name;
  int? quantity;
  int? caloricDensity;
  String? unit;

  Ingredient(this.name, this.quantity, this.caloricDensity, this.unit);
}
