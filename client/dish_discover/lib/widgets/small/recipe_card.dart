import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_top/scroll_to_top.dart';

import '../../entities/recipe.dart';

class RecipeCard extends StatefulWidget {
  ChangeNotifierProvider<Recipe> recipeProvider;
  RecipeCard({super.key, required this.recipeProvider});

  @override
  State<StatefulWidget> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
        aspectRatio: 1.2,
        child: Card(child: Center(child: Text('Recipe Card'))));
  }
}

class RecipeList extends StatefulWidget {
  final List<Recipe> recipes;
  const RecipeList({super.key, required this.recipes});

  @override
  State<StatefulWidget> createState() => _RecipeCardState();
}

class _RecipeListState extends State<RecipeList> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollToTop(
        scrollController: scrollController,
        child: ListView.builder(
            controller: scrollController,
            itemBuilder: (context, index) => RecipeCard(
                recipeProvider: ChangeNotifierProvider<Recipe>(
                    (ref) => widget.recipes[index]))));
  }
}
