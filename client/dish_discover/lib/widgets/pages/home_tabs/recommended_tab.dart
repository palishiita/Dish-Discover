import 'package:dish_discover/widgets/small/recipe_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../entities/app_state.dart';
import '../../../entities/recipe.dart';
import '../../small/tab_title.dart';

class RecommendedTab extends StatefulWidget {
  const RecommendedTab({super.key});

  @override
  State<StatefulWidget> createState() => _RecommendedTabState();
}

class _RecommendedTabState extends State<RecommendedTab> {
  late List<Recipe> recipes;

  @override
  void initState() {
    super.initState();
    recipes = AppState.currentUser!.getRecommendations();
    if (kDebugMode && recipes.isEmpty) {
      // recipes = [
      //   Recipe(title: 'Test 1'),
      //   Recipe(title: 'Test 2'),
      //   Recipe(title: 'Test 3')
      // ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TabTitle(title: 'Recommended'),
      Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
          child: RecipeList(recipes: recipes))
    ]);
  }
}