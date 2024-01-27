import 'package:dish_discover/entities/ingredient.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../entities/app_state.dart';
import '../../../entities/recipe.dart';
import '../../../entities/tag.dart';
import '../../display/recipe_list.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TabTitle(title: 'Saved'),
      RecipeList(
          getRecipes: () => Future<List<Recipe>>(() {
                recipes = AppState.currentUser!.savedRecipes;
                if (kDebugMode && recipes.isEmpty) {
                  recipes = [
                    Recipe(
                        author: AppState.currentUser!.username,
                        title: 'My test recipe',
                        description: 'Some description',
                        steps: 'Contents',
                        id: 1,
                        image: Image.asset('assets/images/logo.png'))
                  ];
                  recipes[0].editRecipe(ingredients: [
                    Ingredient(id: 0, name: 'tomato', quantity: 3)
                  ], tags: [
                    Tag(
                        isPredefined: true,
                        name: 'Italian',
                        category: TagCategory.cuisine),
                    Tag(isPredefined: false, name: 'no-bake', category: null)
                  ]);
                }
                return recipes;
              }))
    ]);
  }
}
