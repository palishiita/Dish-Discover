import 'package:dish_discover/widgets/display/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_top/scroll_to_top.dart';

import '../../entities/recipe.dart';
import '../display_with_input/recipe_card.dart';
import '../style/style.dart';
import 'no_results_card.dart';

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
    Duration timeout = const Duration(minutes: 1);
    return FutureBuilder(
        future: Future<bool>(() => true) // TODO getRecipes
            .timeout(timeout),
        builder: (context, value) => value.connectionState !=
                ConnectionState.done
            ? Center(child: LoadingIndicator(timeout: timeout))
            : Expanded(
                child: value.hasError
                    ? const SingleChildScrollView(
                        child: NoResultsCard(timedOut: true))
                    : widget.recipes.isEmpty // TODO use value to get recipes
                        ? const SingleChildScrollView(
                            child: NoResultsCard(timedOut: false))
                        : ScrollToTop(
                            mini: true,
                            btnColor: buttonColor,
                            scrollController: scrollController,
                            child: ListView.builder(
                                controller: scrollController,
                                itemCount: widget.recipes.length,
                                itemBuilder: (context, index) => RecipeCard(
                                    recipeProvider:
                                        ChangeNotifierProvider<Recipe>((ref) =>
                                            widget.recipes[index]))))));
  }
}
