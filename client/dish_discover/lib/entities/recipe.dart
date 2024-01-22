import 'dart:convert';

import 'package:dish_discover/entities/comment.dart';
import 'package:dish_discover/entities/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'ingredient.dart';

class Recipe extends ChangeNotifier {
  int? id;
  int? authorId;
  String? title;
  String? content;
  String? description;
  List<String>? steps;
  Image? image;
  bool? isBoosted;
  List<Ingredient>? ingredients;
  List<Tag>? tags;
  List<Comment>? comments;

  Recipe({
    this.id,
    this.authorId,
    this.title,
    this.content,
    this.description,
    this.steps,
    this.image,
    this.isBoosted,
    this.ingredients,
    this.tags,
    this.comments,
  });

  Recipe.fromJson(Map<String, dynamic> json);

  void editRecipe({
    String? title,
    String? description,
    String? content,
    Image? image,
  }) {
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.content = content ?? this.content;
    this.image = image ?? this.image;
    notifyListeners();
  }

  void addIngredient(Ingredient ingredient) {
    ingredients?.add(ingredient);
    notifyListeners();
  }

  void addTag(Tag tag) {
    tags?.add(tag);
    notifyListeners();
  }

  Future<List<Recipe>> getRecipes() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/recipes/'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['recipes'];
      return data.map((item) => Recipe.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load items, status code: ${response.reasonPhrase}');
    }
  }
}
