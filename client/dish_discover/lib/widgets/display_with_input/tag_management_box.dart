import 'package:dish_discover/widgets/display_with_input/tag_chip.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entities/tag.dart';
import '../dialogs/custom_dialog.dart';
import '../inputs/custom_dropdown.dart';

class TagManagementBox extends StatefulWidget {
  const TagManagementBox({super.key});

  @override
  State<StatefulWidget> createState() => _TagManagementBoxState();
}

class _TagManagementBoxState extends State<TagManagementBox> {
  @override
  Widget build(BuildContext context) {
    List<Tag> popularNotPredefined = []; // TODO get popular not predefined

    if (kDebugMode && popularNotPredefined.isEmpty) {
      popularNotPredefined = [
        Tag(false, 'name 1', TagCategory.cuisine),
        Tag(false, 'name 1', TagCategory.time),
        // Tag(false, 'name 1', TagCategory.difficulty),
        // Tag(false, 'name 1', TagCategory.ingredient),
        // Tag(false, 'name 1', TagCategory.diet),
        // Tag(false, 'name 1', TagCategory.expense),
      ];
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: AspectRatio(
            aspectRatio: 0.6,
            child: Card(
                child: Column(children: [
              const Center(child: Text('Tag Management Box')),
              Column(
                  children: List.generate(
                      popularNotPredefined.length,
                      (index) => Row(children: [
                            TagChip(
                                tag: popularNotPredefined[index], long: true),
                            IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => CustomDialog.callDialog(
                                        context,
                                        'Add predefined tag',
                                        '#${popularNotPredefined[index].name} : ${popularNotPredefined[index].category?.name}',
                                        null,
                                        CustomDropdown(
                                            currentValue:
                                                popularNotPredefined[index]
                                                    .category,
                                            labeledOptions: List.generate(
                                                TagCategory.values.length,
                                                (index) => (
                                                      TagCategory.values[index],
                                                      TagCategory
                                                          .values[index].name
                                                    )),
                                            onChanged: (selected) {
                                              // TODO change selected option
                                            }),
                                        'Add', () {
                                      // TODO add tag to predefined
                                    }))
                          ])))
            ]))));
  }
}