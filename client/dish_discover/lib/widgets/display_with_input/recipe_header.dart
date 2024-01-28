import 'package:dish_discover/widgets/display/tab_title.dart';
import 'package:dish_discover/widgets/pages/user.dart';
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
    bool likedRecipe = AppState.currentUser!.username == recipe.author
        ? true
        : AppState.currentUser!.likedRecipes.contains(recipe);
    bool savedRecipe = AppState.currentUser!.username == recipe.author
        ? true
        : AppState.currentUser!.savedRecipes.contains(recipe);

    return ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 170),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TabTitle(title: recipe.title),
          GestureDetector(
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(recipe.author,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.black54))),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => UserPage(username: recipe.author)))),
          Center(
              child: Text(recipe.description,
                  softWrap: true, overflow: TextOverflow.fade)),
          LikeSaveIndicator(
              likeButtonEnabled: likedRecipe,
              likeCount: recipe.likeCount,
              onLikePressed: AppState.currentUser!.username == recipe.author
                  ? null
                  : () => AppState.currentUser!
                      .switchLikeRecipe(recipe, !likedRecipe),
              saveButtonEnabled: savedRecipe,
              saveCount: recipe.saveCount, // recipe.saves
              onSavePressed: AppState.currentUser!.username == recipe.author
                  ? null
                  : () => AppState.currentUser!
                      .switchSaveRecipe(recipe, !savedRecipe),
              center: true),
          const Divider()
        ]));
  }
}
