import 'package:dish_discover/widgets/dialogs/filter_side_menu.dart';
import 'package:dish_discover/widgets/inputs/custom_search_bar.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';

import '../../entities/recipe.dart';
import '../display/recipe_list.dart';

class SearchPage extends StatelessWidget {
  final String searchPhrase;
  const SearchPage({super.key, required this.searchPhrase});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          scrolledUnderElevation: 0.0,
          title: const Text('Search'),
          centerTitle: true,
          leading: const BackButton(),
          actions: [
            IconButton(
                onPressed: () => scaffoldKey.currentState!.openEndDrawer(),
                icon: const Icon(Icons.tune_rounded))
          ],
        ),
        body: Column(children: [
          CustomSearchBar(
              initialSearchPhrase: searchPhrase, goToSearchPage: false),
          RecipeList(
              getRecipes: () => Future<List<Recipe>>(() {
                    // TODO search recipes by phrase
                    return [];
                  }))
        ]),
        endDrawer: const FilterSideMenu());
  }
}
