import 'package:dish_discover/widgets/inputs/popup_menu.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';

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
          actions: const [
            PopupMenu(
                action1: PopupMenuAction.boost, action2: PopupMenuAction.delete)
          ],
        ),
        body: Center(child: Text("Edit recipe ${recipe.title}")));
  }
}
