import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/user.dart';

class UserAvatar extends ConsumerWidget {
  final ChangeNotifierProvider<User> userProvider;
  final double diameter;
  const UserAvatar(
      {super.key, required this.userProvider, this.diameter = 70.0});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Image image = (ref.watch(userProvider).image as Image?) ??
        Image.asset("assets/images/default_avatar.jpg");

    return Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(fit: BoxFit.fill, image: image.image)));
  }
}
