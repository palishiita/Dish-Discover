import 'package:dish_discover/widgets/pages/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/user.dart';

class UserAvatar extends StatelessWidget {
  final Image? image;
  final double diameter;
  final ChangeNotifierProvider<User>? userProvider;

  const UserAvatar(
      {super.key,
      required this.image,
      this.diameter = 70.0,
      this.userProvider});

  @override
  Widget build(BuildContext context) {
    Image img = image ?? Image.asset("assets/images/default_avatar.jpg");

    return GestureDetector(
        onTap: userProvider == null
            ? () {}
            : () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => UserPage(userProvider: userProvider!))),
        child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
                radius: diameter / 2,
                foregroundImage: image?.image,
                backgroundImage:
                    Image.asset("assets/images/default_avatar.jpg").image,
                backgroundColor: Colors.blueGrey)));
  }
}
