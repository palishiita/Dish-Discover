import 'package:dish_discover/widgets/pages/search.dart';
import 'package:flutter/material.dart';

import '../../entities/tag.dart';
import '../style/style.dart';

class TagChip extends StatelessWidget {
  final Tag tag;
  final bool long;
  final IconData? icon;
  final void Function()? onPressed;

  const TagChip(
      {super.key,
      required this.tag,
      this.long = false,
      this.icon = Icons.close,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return onPressed == null
        ? FilterChip(
            selected: true,
            showCheckmark: false,
            selectedColor: outerContainerColor(context),
            label: long
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text('#${tag.name}', overflow: TextOverflow.fade),
                        Text(" 0" // TODO get tags count
                            )
                      ])
                : Text('#${tag.name}', overflow: TextOverflow.fade),
            onSelected: (value) => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SearchPage(
                      searchPhrase: "",
                      filter: [tag],
                    ))))
        : InputChip(
            selected: true,
            showCheckmark: false,
            selectedColor: outerContainerColor(context),
            label: long
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        Text('#${tag.name}', overflow: TextOverflow.fade),
                        Text(" 0" // TODO get tags count
                            )
                      ])
                : Text('#${tag.name}', overflow: TextOverflow.fade),
            deleteIcon: Icon(icon),
            onDeleted: onPressed);
  }
}
