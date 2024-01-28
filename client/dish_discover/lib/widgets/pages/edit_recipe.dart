import 'package:dish_discover/widgets/dialogs/custom_dialog.dart';
import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:dish_discover/widgets/inputs/popup_menu.dart';
import 'package:dish_discover/widgets/pages/payment.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';
import '../display/loading_indicator.dart';
import '../display_with_input/recipe_header.dart';
import '../display_with_input/steps_box.dart';
import '../display_with_input/tags_box.dart';

class EditRecipePage extends ConsumerStatefulWidget {
  static const routeName = "/edit";
  final int recipeId;
  final ChangeNotifierProvider<Recipe>? recipeProvider;

  const EditRecipePage(
      {super.key, required this.recipeId, this.recipeProvider});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends ConsumerState<EditRecipePage> {
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
          toolbarHeight: appBarHeight,
          scrolledUnderElevation: 0.0,
          leading: const BackButton(),
          actions: [
            PopupMenu(
                action1: PopupMenuAction.boost,
                onPressed1: recipe.isBoosted
                    ? null
                    : () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const PaymentPage(buyingPremium: false))),
                action2: PopupMenuAction.delete,
                onPressed2: () => CustomDialog.callDialog(
                      context,
                      'Delete recipe',
                      'Deletion is irreversible!',
                      null,
                      CustomTextField(
                          controller: TextEditingController(),
                          hintText: 'Password',
                          obscure: true),
                      'Delete',
                      () {
                        // TODO delete recipe
                      },
                    ))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              RecipeHeader(recipeProvider: recipeProvider!, forEditing: true),
              //IngredientsBox(
              //    recipeProvider: widget.recipeProvider!, forEditing: true),
              StepsBox(recipeProvider: recipeProvider!, forEditing: true),
              TagsBox(recipeProvider: recipeProvider!, forEditing: true)
            ])));
  }
}
