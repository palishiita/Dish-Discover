import 'package:dish_discover/widgets/display/tab_title.dart';
import 'package:dish_discover/widgets/display_with_input/tag_chip.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';
import '../../entities/tag.dart';

class TagsBox extends ConsumerWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  final bool forEditing;
  const TagsBox(
      {super.key, required this.recipeProvider, this.forEditing = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(recipeProvider);
    List<Tag> tags = recipe.tags;

    if (kDebugMode && tags.isEmpty) {
      tags = [
        Tag(
            isPredefined: false,
            name: 'short',
            category: TagCategory.ingredient),
        Tag(
            isPredefined: false,
            name: 'medium name',
            category: TagCategory.ingredient),
        Tag(
            isPredefined: false,
            name: 'loooooooong name',
            category: TagCategory.ingredient),
        Tag(
            isPredefined: false,
            name: 'very looooooooooong name',
            category: TagCategory.ingredient),
        Tag(
            isPredefined: false,
            name: 'veryyyyyyyyyyyyyyyyyy long name',
            category: TagCategory.ingredient)
      ];
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Card(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                child: Column(children: [
                  const TabTitle(title: "Tags"),
                  Wrap(
                      children: List.generate(
                          tags.length,
                          (index) => Padding(
                              padding: const EdgeInsets.all(5),
                              child: TagChip(
                                  tag: tags[index],
                                  onPressed: () {
                                    ref
                                        .watch(recipeProvider)
                                        // TODO remove Tag
                                        .addTag(tags[index]);
                                  }))))
                ]))));
  }
}
