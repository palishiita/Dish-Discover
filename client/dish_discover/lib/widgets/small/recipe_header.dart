import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';

class RecipeHeader extends ConsumerWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  const RecipeHeader({super.key, required this.recipeProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(recipeProvider);

    return ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 100),
        child: const Center(child: Text("Image=?? Likes=?? Saves=??")));
  }
}
