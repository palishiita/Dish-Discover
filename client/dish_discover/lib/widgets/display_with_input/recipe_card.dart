import 'package:dish_discover/widgets/display/recipe_cover.dart';
import 'package:dish_discover/widgets/display/user_avatar.dart';
import 'package:dish_discover/widgets/display_with_input/like_save_indicator.dart';
import 'package:dish_discover/widgets/inputs/popup_menu.dart';
import 'package:dish_discover/widgets/pages/view_recipe.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scroll_to_top/scroll_to_top.dart';

import '../../entities/app_state.dart';
import '../../entities/recipe.dart';
import '../../entities/user.dart';
import '../display/no_results_card.dart';
import '../pages/user.dart';

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
    User author =
        recipe.author ?? User(username: 'unknown', isModerator: false);
    bool likedRecipe =
        AppState.currentUser!.likedRecipes?.contains(recipe) ?? false;
    bool savedRecipe =
        AppState.currentUser!.savedRecipes?.contains(recipe) ?? false;

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: GestureDetector(
            child: AspectRatio(
                aspectRatio: 1.2,
                child: Card(
                    child: Column(children: [
                  ListTile(
                      leading: UserAvatar(
                          image: author.image,
                          diameter: 30,
                          userProvider:
                              ChangeNotifierProvider<User>((ref) => author)),
                      title: Text(recipe.title ?? 'null'),
                      subtitle: GestureDetector(
                          onTap: author == null
                              ? null
                              : () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => UserPage(
                                          userProvider:
                                              ChangeNotifierProvider<User>(
                                                  (ref) => author)))),
                          child: Text(author.username ?? 'null')),
                      trailing: PopupMenu(
                          action1: PopupMenuAction.share,
                          action2: AppState.currentUser!.isModerator
                              ? PopupMenuAction.ban
                              : PopupMenuAction.report)),
                  const Divider(height: 1.0),
                  RecipeCover(cover: recipe.coverImage),
                  const Divider(height: 1.0),
                  LikeSaveIndicator(
                      likeButtonSelected: likedRecipe,
                      likeCount: 0, //recipe.likes,
                      saveButtonEnabled: savedRecipe,
                      saveCount: 0 //recipe.saves
                      )
                ]))),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ViewRecipePage(recipeProvider: widget.recipeProvider)))));
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
    return Expanded(
        child: widget.recipes.isEmpty
            ? const SingleChildScrollView(child: NoResultsCard())
            : ScrollToTop(
                mini: true,
                btnColor: buttonColor,
                scrollController: scrollController,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: widget.recipes.length,
                    itemBuilder: (context, index) => RecipeCard(
                        recipeProvider: ChangeNotifierProvider<Recipe>(
                            (ref) => widget.recipes[index])))));
  }
}
