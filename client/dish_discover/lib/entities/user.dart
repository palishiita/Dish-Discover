import 'dart:ui' as ui;

import 'package:dish_discover/entities/recipe.dart';

class User {
  String? username;
  String? _password;
  String? _email;
  List<Recipe>? likedRecipes;
  bool? isPremium;
  List<Comment>? addedComments;
  List<Recipe>? addedRecipes;
  ui.Image? image;
  String? _description;
  DateTime? unbanDate;
  List<Recipe>? savedRecipes;

  User(
      this.username,
      this._password,
      this._email,
      this.likedRecipes,
      this.isPremium,
      this.addedComments,
      this.addedRecipes,
      this.image,
      this._description,
      this.unbanDate,
      this.savedRecipes);

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
    _password = password ?? _password;
    this.image = image ?? this.image;
    _description = description ?? _description;
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
      super.username,
      super.password,
      super.email,
      super.likedRecipes,
      super.isPremium,
      super.addedComments,
      super.addedRecipes,
      super.image,
      super.description,
      super.unbanDate,
      super.savedRecipes);

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
