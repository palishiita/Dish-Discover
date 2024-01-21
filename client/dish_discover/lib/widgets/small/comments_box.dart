import 'package:dish_discover/widgets/small/tab_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';

class CommentsBox extends ConsumerWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  const CommentsBox({super.key, required this.recipeProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(recipeProvider);

    return ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 100),
        child: Center(
            child: Column(children: [
          const TabTitle(title: "Comments"),
          Text(recipe.comments?.toString() ?? 'null')
        ])));
  }
}
