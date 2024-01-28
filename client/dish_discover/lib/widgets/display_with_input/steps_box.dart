import 'package:dish_discover/widgets/display/tab_title.dart';
import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:dish_discover/widgets/inputs/popup_menu.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/recipe.dart';

class StepsBox extends ConsumerWidget {
  final ChangeNotifierProvider<Recipe> recipeProvider;
  final bool forEditing;
  const StepsBox(
      {super.key, required this.recipeProvider, this.forEditing = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(recipeProvider);

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
          const TabTitle(title: "Steps"),
          DecoratedBox(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black54)),
              child: Card(
                  color: textEditorColor,
                  shadowColor: Colors.transparent,
                  child: forEditing
                      ? CustomTextField(
                          controller: TextEditingController(
                              text: recipe.steps), // TODO pass edited text back
                          hintText: 'Markdown text',
                          maxLength: 3000)
                      : Markdown(
                          physics: const NeverScrollableScrollPhysics(),
                          data: recipe.steps,
                          onTapLink: (alias, url, _) =>
                              PopupMenuAction.shareAction(context, alias,
                                  'Check this out: ', url ?? 'null'),
                          selectable: true,
                          shrinkWrap: true,
                          softLineBreak: true)))
        ])));
  }
}
