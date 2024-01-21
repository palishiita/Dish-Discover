import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';

class LikeSaveIndicator extends StatelessWidget {
  final int likeCount;
  final bool likeButtonSelected;
  final int saveCount;
  final bool saveButtonEnabled;
  final bool center;

  const LikeSaveIndicator(
      {super.key,
      required this.likeButtonSelected,
      required this.likeCount,
      required this.saveButtonEnabled,
      required this.saveCount,
      this.center = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
            mainAxisAlignment:
                center ? MainAxisAlignment.center : MainAxisAlignment.start,
            children: [
              IconButton(
                  icon: Icon(Icons.favorite_border_outlined, color: likeColor),
                  selectedIcon: Icon(Icons.favorite, color: likeColor),
                  isSelected: likeButtonSelected,
                  onPressed: likeButtonSelected ? null : () {}),
              Text(likeCount.toString()),
              IconButton(
                  icon: Icon(Icons.bookmark_border, color: saveColor),
                  selectedIcon: Icon(Icons.bookmark, color: saveColor),
                  isSelected: saveButtonEnabled,
                  onPressed: saveButtonEnabled ? null : () {}),
              Text(saveCount.toString())
            ]));
  }
}
