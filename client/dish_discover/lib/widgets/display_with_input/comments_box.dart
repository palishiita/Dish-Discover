import 'package:dish_discover/widgets/display/tab_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';

class CommentsBox extends ConsumerWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  const CommentsBox({super.key, required this.recipeProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(recipeProvider);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Card(
            child: Column(children: [
          const TabTitle(title: "Comments"),
          Center(child: Text((recipe.comments ?? []).toString()))
        ])));
  }
}
