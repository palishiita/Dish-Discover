import 'package:dish_discover/widgets/dialogs/custom_dialog.dart';
import 'package:dish_discover/widgets/display/recipe_cover.dart';
import 'package:dish_discover/widgets/display/user_avatar.dart';
import 'package:dish_discover/widgets/display_with_input/like_save_indicator.dart';
import 'package:dish_discover/widgets/display_with_input/tag_chip.dart';
import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:dish_discover/widgets/inputs/popup_menu.dart';
import 'package:dish_discover/widgets/pages/view_recipe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../entities/app_state.dart';
import '../../entities/recipe.dart';
import '../../entities/tag.dart';
import '../../entities/user.dart';
import '../pages/user.dart';

class RecipeCard extends ConsumerWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  const RecipeCard({super.key, required this.recipeProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(recipeProvider);
    bool likedRecipe = AppState.currentUser!.username == recipe.author
        ? true
        : AppState.currentUser!.likedRecipes.contains(recipe);
    bool savedRecipe = AppState.currentUser!.username == recipe.author
        ? true
        : AppState.currentUser!.savedRecipes.contains(recipe);
    List<Tag> tags = recipe.tags;

    return FutureBuilder(
        future: User.getUser(recipe.author).timeout(const Duration(minutes: 1)),
        builder: (context, author) {
          ChangeNotifierProvider<User>? authorProvider = author.data == null
              ? null
              : ChangeNotifierProvider((ref) => author.data!);

          if (kDebugMode && authorProvider == null) {
            authorProvider = ChangeNotifierProvider((ref) =>
                User(username: recipe.author, password: '', email: ''));
          }

          return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: GestureDetector(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ViewRecipePage(recipeProvider: recipeProvider))),
                  child: AspectRatio(
                      aspectRatio: 1.2,
                      child: Card(
                          child: Column(children: [
                        ListTile(
                            leading: UserAvatar(
                                image: author.data?.image,
                                diameter: 30,
                                userProvider: authorProvider),
                            title: Text(recipe.title),
                            subtitle: GestureDetector(
                                onTap: authorProvider == null
                                    ? () {}
                                    : () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => UserPage(
                                                userProvider:
                                                    authorProvider!))),
                                child: Text(author.data?.username ?? 'null')),
                            trailing: PopupMenu(
                                action1: PopupMenuAction.share,
                                onPressed1: () async =>
                                    await FlutterShare.share(
                                        title: 'Share recipe',
                                        text: recipe.title,
                                        linkUrl: '[link]'), // TODO link
                                action2: AppState.currentUser!.isModerator
                                    ? PopupMenuAction.ban
                                    : PopupMenuAction.report,
                                onPressed2: () =>
                                    AppState.currentUser!.isModerator
                                        ? {
                                            CustomDialog.callDialog(
                                                context,
                                                'Ban recipe',
                                                '',
                                                null,
                                                Column(children: [
                                                  CustomTextField(
                                                      controller:
                                                          TextEditingController(),
                                                      hintText: 'Password',
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
                                                      controller:
                                                          TextEditingController(),
                                                      hintText: 'Reason',
                                                      obscure: true)
                                                ]),
                                                'Report',
                                                () {})
                                          })),
                        const Divider(height: 1.0),
                        RecipeCover(cover: recipe.image),
                        const Divider(height: 1.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LikeSaveIndicator(
                                  likeButtonEnabled: likedRecipe,
                                  likeCount: recipe.likeCount,
                                  onLikePressed:
                                      AppState.currentUser!.username ==
                                              recipe.author
                                          ? null
                                          : () => AppState.currentUser!
                                              .switchLikeRecipe(
                                                  recipe, !likedRecipe),
                                  saveButtonEnabled: savedRecipe,
                                  saveCount: recipe.saveCount,
                                  onSavePressed: AppState
                                              .currentUser!.username ==
                                          recipe.author
                                      ? null
                                      : () => AppState.currentUser!
                                          .switchSaveRecipe(
                                              recipe, !savedRecipe)),
                              Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: CustomPopup(
                                    content: Wrap(
                                        children: List.generate(
                                            tags.length,
                                            (index) => Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: TagChip(
                                                    tag: tags[index],
                                                    icon: null,
                                                    onPressed: null)))),
                                    child: const Icon(Icons.sell_outlined),
                                  ))
                            ])
                      ])))));
        });
  }
}
