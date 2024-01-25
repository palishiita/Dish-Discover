import 'package:dish_discover/entities/comment.dart';
import 'package:dish_discover/entities/ingredient.dart';
import 'package:dish_discover/entities/recipe.dart';
import 'package:dish_discover/entities/tag.dart';
import 'package:dish_discover/entities/ticket.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User extends ChangeNotifier {
  int? id;
  String? username;
  String? password;
  String? email;
  bool? isPremium;
  Image? image;
  String? description;
  DateTime? unbanDate;
  bool isModerator;
  List<Recipe>? likedRecipes;
  List<Recipe>? savedRecipes;
  List<Recipe>? addedRecipes;
  List<Comment>? addedComments;
  List<Tag>? preferredTags;

  User({
    this.id,
    this.username,
    this.password,
    this.email,
    this.isPremium,
    this.image,
    this.description,
    this.unbanDate,
    required this.isModerator,
    this.likedRecipes,
    this.savedRecipes,
    this.addedRecipes,
    this.addedComments,
    this.preferredTags,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
      isPremium: json['is_premium'],
      image: json['image'] != null ? Image.network(json['image']) : null,
      description: json['description'],
      unbanDate: json['unban_date'] != null ? DateTime.parse(json['unban_date']) : null,
      isModerator: json['is_moderator'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'email': email,
      'is_premium': isPremium,
      'image': image?.toString(),
      'description': description,
      'unban_date': unbanDate?.toIso8601String(),
      'is_moderator': isModerator,
    };
  }

  void banUser(User user, DateTime date) {
    if (isModerator == true) {
      user.unbanDate = date;
    }
    notifyListeners();
  }

  void likeRecipe(Recipe recipe) {
    likedRecipes?.add(recipe);
    notifyListeners();
  }

  void saveRecipe(Recipe recipe) {
    savedRecipes?.add(recipe);
    notifyListeners();
  }

  Recipe addRecipe(
      int? recipeId,
      String? title,
      String? content,
      String? description,
      List<String>? steps,
      Image? image,
      bool? isBoosted,
      List<Ingredient>? ingredients,
      List<Tag> tags) {
    Recipe recipe = Recipe(
        id: recipeId,
        authorId: id,
        title: title,
        content: content,
        description: description,
        steps: steps,
        image: image,
        isBoosted: isBoosted,
        ingredients: ingredients,
        tags: tags);
    addedRecipes?.add(recipe);
    notifyListeners();
    return recipe;
  }

  void editProfile(
      {String? username, String? password, Image? image, String? description}) {
    this.username = username ?? this.username;
    password = password ?? password;
    this.image = image ?? this.image;
    description = description ?? description;
    notifyListeners();
  }

  void getPremium() {
    isPremium = true;
    notifyListeners();
  }

  Ticket reportUser(int reportId, Recipe? recipe, User issuer, User violator,
      Comment? comment, String reason) {
    Ticket ticket = Ticket(
        reportId: reportId,
        recipeId: recipe?.id,
        violatorId: violator.username,
        issuerId: issuer.username,
        commentId: comment?.commentId,
        reason: reason);
    notifyListeners();
    return ticket;
  }

  Comment addComment(int commentId, Recipe recipe, String content) {
    Comment comment = Comment(
        authorId: id,
        recipeId: recipe.id,
        commentId: commentId,
        content: content);
    addedComments?.add(comment);
    notifyListeners();
    return comment;
  }

  void editComment(Comment comment, String content) {
    if (id == comment.authorId) {
      comment.content = content;
      notifyListeners();
    }
  }

  Future<List<Recipe>> getRecommendations(User user) async {
    return [];
  }

  Future<void> addUser(User user) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      print('User added successfully');
    } else {
      throw Exception('Failed to add user, status code: ${response.statusCode}');
    }
  }

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/users'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['users'];
      return data.map((item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users, status code: ${response.statusCode}');
    }
  }
}
