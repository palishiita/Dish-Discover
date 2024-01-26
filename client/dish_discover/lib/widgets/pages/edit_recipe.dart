import 'package:dish_discover/widgets/dialogs/custom_dialog.dart';
import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:dish_discover/widgets/inputs/popup_menu.dart';
import 'package:dish_discover/widgets/pages/payment.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';
import '../display_with_input/ingredients_box.dart';
import '../display_with_input/recipe_header.dart';
import '../display_with_input/steps_box.dart';
import '../display_with_input/tags_box.dart';

class EditRecipePage extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;

  const EditRecipePage({super.key, required this.recipeProvider});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditRecipePageState();
}

class _EditRecipePageState extends ConsumerState<EditRecipePage> {
  @override
  Widget build(BuildContext context) {
    Recipe recipe = ref.watch(widget.recipeProvider);
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: appBarHeight,
          scrolledUnderElevation: 0.0,
          leading: const BackButton(),
          actions: [
            PopupMenu(
                action1: PopupMenuAction.boost,
                onPressed1: recipe.isBoosted ?? false
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
              RecipeHeader(
                  recipeProvider: widget.recipeProvider, forEditing: true),
              IngredientsBox(
                  recipeProvider: widget.recipeProvider, forEditing: true),
              StepsBox(recipeProvider: widget.recipeProvider, forEditing: true),
              TagsBox(recipeProvider: widget.recipeProvider, forEditing: true)
            ])));
  }
}
