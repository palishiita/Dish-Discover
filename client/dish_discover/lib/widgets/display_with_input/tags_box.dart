import 'package:dish_discover/widgets/display/tab_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';

class TagsBox extends ConsumerWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  const TagsBox({super.key, required this.recipeProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(recipeProvider);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Card(
            child: Column(children: [
          const TabTitle(title: "Tags"),
          Center(child: Text((recipe.tags ?? []).toString()))
        ])));
  }
}
