import 'package:dish_discover/widgets/dialogs/custom_dialog.dart';
import 'package:dish_discover/widgets/display/recipe_cover.dart';
import 'package:dish_discover/widgets/display/user_avatar.dart';
import 'package:dish_discover/widgets/display_with_input/like_save_indicator.dart';
import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:dish_discover/widgets/inputs/popup_menu.dart';
import 'package:dish_discover/widgets/pages/view_recipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../entities/app_state.dart';
import '../../entities/recipe.dart';
import '../../entities/user.dart';
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
    User author = User(username: 'unknown', isModerator: false);
    //recipe.author ?? User(username: 'unknown', isModerator: false); TODO get author as User
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
                          onPressed1: () async => await FlutterShare.share(
                              title: 'Share recipe',
                              text: recipe.title,
                              linkUrl: '[link]'), // TODO link
                          action2: AppState.currentUser!.isModerator
                              ? PopupMenuAction.ban
                              : PopupMenuAction.report,
                          onPressed2: () => AppState.currentUser!.isModerator
                              ? {
                                  CustomDialog.callDialog(
                                      context,
                                      'Ban recipe',
                                      '',
                                      null,
                                      Column(children: [
                                        CustomTextField(
                                            controller: TextEditingController(),
                                            hintText: 'Password',
                                            obscure: true),
                                        CustomTextField(
                                            controller: TextEditingController(),
                                            hintText: 'Repeat password',
                                            obscure: true)
                                      ]),
                                      'Ban',
                                      () {})
                                }
                              : {
                                  CustomDialog.callDialog(
                                      context,
                                      'Report recipe',
                                      '',
                                      null,
                                      Column(children: [
                                        CustomTextField(
                                            controller: TextEditingController(),
                                            hintText: 'Reason',
                                            obscure: true)
                                      ]),
                                      'Report',
                                      () {})
                                })),
                  const Divider(height: 1.0),
                  RecipeCover(cover: recipe.image),
                  const Divider(height: 1.0),
                  Row(children: [
                    LikeSaveIndicator(
                        likeButtonSelected: likedRecipe,
                        likeCount: 0, //recipe.likes,
                        onLiked: () {
                          setState(() {
                            AppState.currentUser!.likeRecipe(recipe);
                            // TODO update recipe
                          });
                        },
                        saveButtonEnabled: savedRecipe,
                        saveCount: 0, //recipe.saves
                        onSaved: () {
                          setState(() {
                            AppState.currentUser!.saveRecipe(recipe);
                          });
                        }),
                    IconButton(
                        icon: const Icon(Icons.sell_outlined),
                        onPressed: () {
                          // TODO show tag box
                        })
                  ])
                ]))),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ViewRecipePage(recipeProvider: widget.recipeProvider)))));
  }
}
