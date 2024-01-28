import 'package:dish_discover/widgets/inputs/popup_menu.dart';
import 'package:dish_discover/widgets/pages/edit_recipe.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../entities/app_state.dart';
import '../../entities/recipe.dart';
import '../dialogs/custom_dialog.dart';
import '../display/loading_indicator.dart';
import '../display/recipe_cover.dart';
import '../display_with_input/comments_box.dart';
import '../display_with_input/recipe_header.dart';
import '../display_with_input/steps_box.dart';
import '../display_with_input/tags_box.dart';
import '../inputs/custom_text_field.dart';

class ViewRecipePage extends ConsumerStatefulWidget {
  static const routeName = "/recipe";
  final int recipeId;
  final ChangeNotifierProvider<Recipe>? recipeProvider;

  const ViewRecipePage(
      {super.key, required this.recipeId, this.recipeProvider});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewRecipePageState();
}

class _ViewRecipePageState extends ConsumerState<ViewRecipePage> {
  ChangeNotifierProvider<Recipe>? recipeProvider;

  @override
  void initState() {
    super.initState();
    recipeProvider = widget.recipeProvider;
  }

  @override
  Widget build(BuildContext context) {
    return recipeProvider == null ? loading() : done();
  }

  Widget loading() {
    return FutureBuilder(
        future: Future<Recipe>(() => Recipe.getRecipe(widget.recipeId)),
        builder: (context, recipeData) {
          if (recipeData.connectionState != ConnectionState.done) {
            return LoadingIndicator(title: "Recipe #${widget.recipeId}");
          }

          Recipe recipe;
          if (recipeData.data == null) {
            if (kDebugMode) {
              recipe = Recipe(
                  id: widget.recipeId,
                  title: "recipe_${widget.recipeId}_debug",
                  author: "debug",
                  description:
                      "Testing testing testing testing testing testing testing.",
                  image: Image.asset("assets/images/logo.png"));
            } else {
              return LoadingErrorIndicator(title: "Recipe #${widget.recipeId}");
            }
          } else {
            recipe = recipeData.data!;
          }

          recipeProvider = ChangeNotifierProvider<Recipe>((ref) => recipe);

          return done();
        });
  }

  Widget done() {
    Recipe recipe = ref.watch(recipeProvider!);

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 200,
            scrolledUnderElevation: 0.0,
            leading: const BackButton(),
            actions: [
              PopupMenu(
                  action1: PopupMenuAction.share,
                  onPressed1: () async => await FlutterShare.share(
                      title: 'Share recipe',
                      text: recipe.title,
                      linkUrl: '[link]'), // TODO link
                  action2:
                      recipe.author.compareTo(AppState.currentUser!.username) ==
                              0
                          ? PopupMenuAction.edit
                          : AppState.currentUser!.isModerator
                              ? PopupMenuAction.ban
                              : PopupMenuAction.report,
                  onPressed2: () => recipe.author
                              .compareTo(AppState.currentUser!.username) ==
                          0
                      ? {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditRecipePage(recipeId: widget.recipeId)))
                        }
                      : AppState.currentUser!.isModerator
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
                            }),
            ],
            flexibleSpace: AspectRatio(
                aspectRatio: 4 / 3, child: RecipeCover(cover: recipe.image))),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              RecipeHeader(recipeProvider: recipeProvider!),
              //IngredientsBox(recipeProvider: recipeProvider!),
              StepsBox(recipeProvider: recipeProvider!),
              TagsBox(recipeProvider: recipeProvider!),
              CommentsBox(recipeProvider: recipeProvider!)
            ])));
  }
}
