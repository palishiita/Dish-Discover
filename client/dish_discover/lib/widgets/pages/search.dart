import 'package:dish_discover/widgets/inputs/custom_search_bar.dart';
import 'package:flutter/material.dart';

import '../../entities/recipe.dart';
import '../small/recipe_card.dart';
import '../small/tab_title.dart';

class SearchPage extends StatelessWidget {
  final String searchPhrase;
  const SearchPage({super.key, required this.searchPhrase});

  @override
  Widget build(BuildContext context) {
    List<Recipe> recipes =
        []; // TODO AppState.currentUser!.searchRecipe(searchPhrase);
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          toolbarHeight: 50,
          scrolledUnderElevation: 0.0,
          title: const Text('Search'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
                icon: const Icon(Icons.tune_rounded))
          ],
        ),
        body: Column(children: [
          CustomSearchBar(initialSearchPhrase: searchPhrase),
          Expanded(child: RecipeList(recipes: recipes))
        ]),
        endDrawer: const Drawer(
            shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(30.0))),
            child: Column(
              children: [TabTitle(title: 'Filter'), Text('...')],
            )));
  }
}