import 'package:dish_discover/widgets/inputs/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/app_state.dart';
import '../../entities/recipe.dart';
import '../display/recipe_cover.dart';
import '../display_with_input/comments_box.dart';
import '../display_with_input/ingredients_box.dart';
import '../display_with_input/recipe_header.dart';
import '../display_with_input/steps_box.dart';
import '../display_with_input/tags_box.dart';

class ViewRecipePage extends ConsumerWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  const ViewRecipePage({super.key, required this.recipeProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(recipeProvider);

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 200,
            scrolledUnderElevation: 0.0,
            leading: const BackButton(),
            actions: [
              PopupMenu(
                  action1: PopupMenuAction.share,
                  action2: recipe.authorId
                              ?.compareTo(AppState.currentUser!.username!) ==
                          0
                      ? PopupMenuAction.edit
                      : AppState.currentUser!.isModerator
                          ? PopupMenuAction.ban
                          : PopupMenuAction.report),
            ],
            flexibleSpace: AspectRatio(
                aspectRatio: 4 / 3, child: RecipeCover(cover: recipe.image))),
        body: SingleChildScrollView(
            child: Column(children: [
          RecipeHeader(recipeProvider: recipeProvider),
          IngredientsBox(recipeProvider: recipeProvider),
          StepsBox(recipeProvider: recipeProvider),
          TagsBox(recipeProvider: recipeProvider),
          CommentsBox(recipeProvider: recipeProvider)
        ])));
  }
}
