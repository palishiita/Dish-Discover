import 'dart:convert';

import 'package:dish_discover/entities/comment.dart';
import 'package:dish_discover/entities/tag.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'ingredient.dart';

class Recipe extends ChangeNotifier {
  int? id;
  String? authorId;
  String? title;
  String? content;
  String? description;
  String? steps;
  Image? image;
  bool? isBoosted;
  List<Ingredient>? ingredients;
  List<Tag>? tags;
  List<Comment>? comments;
  int likeCount = 0;
  int saveCount = 0;

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

  Map<String, dynamic> toJson() {
    return {
      'recipe_id': id,
      'recipe_name': title,
      'content': content,
      'picture': image?.toString(),
      'description': description,
      'is_boosted': isBoosted,
      'author': authorId,
    };
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['recipe_id'],
      title: json['recipe_name'],
      content: json['content'],
      image: json['picture'],
      description: json['description'],
      isBoosted: json['is_boosted'],
      authorId: json['author'],
      // ingredients: List<int>.from(json['ingredients']),
      // tags: List<String>.from(json['tags']),
    );
  }

  void editRecipe(
      {String? title,
      String? description,
      String? content,
      Image? image,
      String? steps}) {
    this.title = title ?? this.title;
    this.description = description ?? this.description;
    this.content = content ?? this.content;
    this.image = image ?? this.image;
    this.steps = steps ?? this.steps;
    notifyListeners();
  }

  void addIngredient(Ingredient ingredient) {
    ingredients?.add(ingredient);
    notifyListeners();
  }

  void removeIngredient(Ingredient ingredient) {
    ingredients?.remove(ingredient);
    notifyListeners();
  }

  void addTag(Tag tag) {
    tags?.add(tag);
    notifyListeners();
  }

  void removeTag(Tag tag) {
    tags?.remove(tag);
    notifyListeners();
  }

  void updateLikeCount() {
    likeCount++;
    notifyListeners();
  }

  void updateSaveCount() {
    saveCount++;
    notifyListeners();
  }

  Map<String, dynamic> getAuthor() {
    return {
      'authorId': authorId,
      'image': image,
    };
  }

  static Future<List<Recipe>> getRecipes() async {
    final response =
        await http.get(Uri.parse('http://localhost:8000/api/recipes/recipes/'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['recipes'];
      return data.map((item) => Recipe.fromJson(item)).toList();
    } else {
      throw Exception(
          'Failed to load items, status code: ${response.reasonPhrase}');
    }
  }

  static Future<Recipe> getRecipe(int recipeId) async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/recipes/recipes/$recipeId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body)['recipe'];
      return Recipe.fromJson(data);
    } else {
      throw Exception('Failed to load recipe, status code: ${response.reasonPhrase}');
    }
  }

  static Future<List<Ingredient>> getIngredientsForRecipe(int recipeId) async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/recipes/$recipeId/ingredients'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['ingredients'];
      return data.map((item) => Ingredient.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load ingredients, status code: ${response.reasonPhrase}');
    }
  }

  static Future<void> saveRecipe(Recipe recipe) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8000/api/recipes/recipes/${recipe.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: recipe.toJson(),
      );

      if (response.statusCode == 201) {
        print('Recipe saved successfully');
      } else {
        throw Exception(
            'Failed to save recipe, status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error saving recipe: $e');
    }
  }
}
