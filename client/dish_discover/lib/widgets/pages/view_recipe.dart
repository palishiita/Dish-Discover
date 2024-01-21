import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';
import '../small/comments_box.dart';
import '../small/ingredients_box.dart';
import '../small/recipe_header.dart';
import '../small/steps_box.dart';
import '../small/tags_box.dart';

class ViewRecipePage extends StatelessWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  const ViewRecipePage({super.key, required this.recipeProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        RecipeHeader(recipeProvider: recipeProvider),
        IngredientsBox(recipeProvider: recipeProvider),
        StepsBox(recipeProvider: recipeProvider),
        TagsBox(recipeProvider: recipeProvider),
        CommentsBox(recipeProvider: recipeProvider)
      ]),
    );
  }
}
