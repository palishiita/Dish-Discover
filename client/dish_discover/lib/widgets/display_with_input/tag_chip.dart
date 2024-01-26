import 'package:flutter/material.dart';

import '../../entities/tag.dart';
import '../style/style.dart';

class TagChip extends StatelessWidget {
  final Tag tag;
  final bool long;
  final IconData icon;
  final void Function()? onPressed;

  const TagChip(
      {super.key,
      required this.tag,
      this.long = false,
      this.icon = Icons.close,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InputChip(
        selected: true,
        showCheckmark: false,
        selectedColor: outerContainerColor(context),
        label: long
            ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('#${tag.name ?? '[empty]'}'),
                Text(0 // TODO get tags count
                    .toString())
              ])
            : Text('#${tag.name ?? '[empty]'}'),
        deleteIcon: Icon(icon),
        onDeleted: onPressed);
  }
}
