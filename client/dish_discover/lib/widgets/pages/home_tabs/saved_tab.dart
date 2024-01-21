import 'package:dish_discover/widgets/small/recipe_card.dart';
import 'package:flutter/material.dart';

import '../../../entities/app_state.dart';
import '../../../entities/recipe.dart';
import '../../small/tab_title.dart';

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
    return SingleChildScrollView(
        child: Column(children: [
      const TabTitle(title: 'Saved'),
      Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
          child: RecipeList(recipes: recipes))
    ]));
  }
}
