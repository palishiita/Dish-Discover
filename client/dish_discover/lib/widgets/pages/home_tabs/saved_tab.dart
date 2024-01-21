import 'package:dish_discover/widgets/display_with_input/recipe_card.dart';
import 'package:flutter/material.dart';

import '../../../entities/app_state.dart';
import '../../../entities/recipe.dart';
import '../../display/tab_title.dart';

class SavedTab extends StatefulWidget {
  const SavedTab({super.key});

  @override
  State<StatefulWidget> createState() => _SavedTabState();
}

class _SavedTabState extends State<SavedTab> {
  late List<Recipe> recipes;

  @override
  void initState() {
    super.initState();
    recipes = AppState.currentUser!.savedRecipes ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TabTitle(title: 'Saved'),
      RecipeList(recipes: recipes)
    ]);
  }
}
