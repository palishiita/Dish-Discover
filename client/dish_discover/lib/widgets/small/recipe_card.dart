import 'package:dish_discover/widgets/pages/view_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_top/scroll_to_top.dart';

import '../../entities/recipe.dart';
import 'no_results_card.dart';

class RecipeCard extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  const RecipeCard({super.key, required this.recipeProvider});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecipeCardState();
}

class _RecipeCardState extends ConsumerState<RecipeCard> {
  @override
  Widget build(BuildContext context) {
    Recipe recipe = ref.watch(widget.recipeProvider);

    return GestureDetector(
        child: AspectRatio(
            aspectRatio: 1.2,
            child: Card(child: Center(child: Text('Recipe: ${recipe.title}')))),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                ViewRecipePage(recipeProvider: widget.recipeProvider))));
  }
}

class RecipeList extends StatefulWidget {
  final List<Recipe> recipes;
  const RecipeList({super.key, required this.recipes});

  @override
  State<StatefulWidget> createState() => _RecipeListState();
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
    return widget.recipes.isEmpty
        ? const SingleChildScrollView(child: NoResultsCard())
        : ScrollToTop(
            scrollController: scrollController,
            child: ListView.builder(
                controller: scrollController,
                itemCount: widget.recipes.length,
                itemBuilder: (context, index) => RecipeCard(
                    recipeProvider: ChangeNotifierProvider<Recipe>(
                        (ref) => widget.recipes[index]))));
  }
}
