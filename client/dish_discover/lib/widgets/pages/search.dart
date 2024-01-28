import 'package:dish_discover/widgets/dialogs/filter_side_menu.dart';
import 'package:dish_discover/widgets/inputs/custom_search_bar.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';

import '../../entities/recipe.dart';
import '../../entities/tag.dart';
import '../display/recipe_list.dart';

class SearchPage extends StatefulWidget {
  static const routeName = "/search";
  final String searchPhrase;
  final List<Tag>? filter;

  const SearchPage({super.key, required this.searchPhrase, this.filter});

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Tag> currentFilter;

  @override
  void initState() {
    super.initState();
    currentFilter = widget.filter ?? [];
  }

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
              initialSearchPhrase: widget.searchPhrase, goToSearchPage: false),
          RecipeList(
              getRecipes: () => Future<List<Recipe>>(() {
                    // TODO search recipes by phrase
                    return [];
                  }))
        ]),
        endDrawer: FilterSideMenu(
            filter: currentFilter,
            onSaved: (newFilter) => setState(() {
                  currentFilter = newFilter;
                })));
  }
}
