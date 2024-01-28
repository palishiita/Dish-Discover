import 'package:dish_discover/widgets/display/tab_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';

class IngredientsBox extends ConsumerStatefulWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  final bool forEditing;
  const IngredientsBox(
      {super.key, required this.recipeProvider, this.forEditing = false});

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
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Card(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(child: TabTitle(title: "Ingredients"))),
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                  recipe.ingredients.length,
                  (index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("\u2022  ${recipe.ingredients[index].name}",
                          overflow: TextOverflow.fade))))
        ])));
  }
}
