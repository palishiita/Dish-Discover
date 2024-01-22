import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../entities/app_state.dart';
import '../../../entities/recipe.dart';
import '../../display/recipe_list.dart';
import '../../display/tab_title.dart';

class RecommendedTab extends StatefulWidget {
  const RecommendedTab({super.key});

  @override
  State<StatefulWidget> createState() => _RecommendedTabState();
}

class _RecommendedTabState extends State<RecommendedTab> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future<void>(() async => recipes = kDebugMode
            ? [
                Recipe(title: 'Test 1'),
                Recipe(title: 'Test 2'),
                Recipe(title: 'Test 3')
              ]
            : await AppState.currentUser!.getRecommendations()),
        builder: (context, value) => Column(children: [
              const TabTitle(title: 'Recommended'),
              RecipeList(recipes: recipes)
            ]));
  }
}
