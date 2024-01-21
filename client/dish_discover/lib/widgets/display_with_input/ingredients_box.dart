import 'package:dish_discover/widgets/display/tab_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';

class IngredientsBox extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  const IngredientsBox({super.key, required this.recipeProvider});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _IngredientsBoxState();
}

class _IngredientsBoxState extends ConsumerState<IngredientsBox> {
  late double multiplier;

  @override
  void initState() {
    super.initState();
    multiplier = 1.0;
  }

  @override
  Widget build(BuildContext context) {
    Recipe recipe = ref.watch(widget.recipeProvider);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Card(
            child: Column(children: [
          const TabTitle(title: "Ingredients"),
          Center(child: Text((recipe.ingredients ?? []).toString()))
        ])));
  }
}
