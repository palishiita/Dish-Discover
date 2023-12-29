import 'dart:ui' as ui;

import 'package:dish_discover/entities/recipe.dart';

class User {
  String? username;
  String? password;
  String? email;
  List<Recipe>? likedRecipes;
  bool? isPremium;
  bool isModerator;
  List<Comment>? addedComments;
  List<Recipe>? addedRecipes;
  ui.Image? image;
  String? description;
  DateTime? unbanDate;
  List<Recipe>? savedRecipes;

  User(
      {this.username,
      this.password,
      this.email,
      this.likedRecipes,
      this.isPremium,
      required this.isModerator,
      this.addedComments,
      this.addedRecipes,
      this.image,
      this.description,
      this.unbanDate,
      this.savedRecipes});

  void addRecipe(Recipe recipe) {
    likedRecipes?.add(recipe);
  }

  void addComment(Comment comment) {
    addedComments?.add(comment);
  }

  void boostOwnRecipe(Recipe recipe) {
    if (addedRecipes!.contains(recipe) && recipe.isBoosted != true) {
      recipe.isBoosted = true;
    }
  }

  void report(User user) {
    ////////???????????????????
  }

  void editProfile(
      {String? username,
      String? password,
      ui.Image? image,
      String? description}) {
    this.username = username ?? this.username;
    this.password = password ?? password;
    this.image = image ?? this.image;
    this.description = description ?? description;
  }

  void getPremium() {
    isPremium = true;
  }

  void likeRecipe(Recipe recipe) {
    if (!likedRecipes!.contains(recipe)) {
      likedRecipes?.add(recipe);
    }
  }

  void unlikeRecipe(Recipe recipe) {
    if (likedRecipes!.contains(recipe)) {
      likedRecipes?.remove(recipe);
    }
  }

  void saveRecipe(Recipe recipe) {
    if (!savedRecipes!.contains(recipe)) {
      savedRecipes?.add(recipe);
    }
  }

  void unsaveRecipe(Recipe recipe) {
    if (savedRecipes!.contains(recipe)) {
      savedRecipes?.remove(recipe);
    }
  }

  void searchRecipe(Recipe recipe) {
    // ?????????????????????????
  }

  void getRecommendations() {
    // ?????????????????????????
  }

  void createUser() {
    // ?????????????????????????
  }
}

class Moderator extends User {
  Moderator(
      {super.username,
      super.password,
      super.email,
      super.likedRecipes,
      super.isPremium,
      super.isModerator = true,
      super.addedComments,
      super.addedRecipes,
      super.image,
      super.description,
      super.unbanDate,
      super.savedRecipes});

  void viewReportTickets() {
    // ????????????????????????
  }

  void banUser(User user, DateTime date) {
    user.unbanDate = date;
  }

  void addPredefinedTag() {
    // ??????????????????????????
  }
}
