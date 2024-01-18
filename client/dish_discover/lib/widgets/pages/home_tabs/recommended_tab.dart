import 'package:dish_discover/widgets/small/no_results_card.dart';
import 'package:dish_discover/widgets/small/recipe_card.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
      const TabTitle(title: 'Recommended'),
      Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
          child: recipes.isEmpty
              ? const NoResultsCard()
              : RecipeList(recipes: recipes))
    ]));
  }
}
