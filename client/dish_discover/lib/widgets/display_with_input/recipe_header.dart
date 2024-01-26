import 'package:dish_discover/widgets/display/tab_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/app_state.dart';
import '../../entities/recipe.dart';
import 'like_save_indicator.dart';

class RecipeHeader extends ConsumerWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  final bool forEditing;
  const RecipeHeader(
      {super.key, required this.recipeProvider, this.forEditing = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(recipeProvider);
    bool likedRecipe =
        AppState.currentUser!.likedRecipes?.contains(recipe) ?? false;
    bool savedRecipe =
        AppState.currentUser!.savedRecipes?.contains(recipe) ?? false;

    return ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 170),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TabTitle(title: recipe.title ?? '[Title]'),
          Center(child: Text(recipe.description ?? '[Description]')),
          LikeSaveIndicator(
              likeButtonSelected: likedRecipe,
              likeCount: 0, // recipe.likes
              onLiked: () {
                AppState.currentUser!.likeRecipe(recipe);
              },
              saveButtonEnabled: savedRecipe,
              saveCount: 0, // recipe.saves
              onSaved: () {
                AppState.currentUser!.likeRecipe(recipe);
              },
              center: true),
          const Divider()
        ]));
  }
}
