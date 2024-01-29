import 'package:dish_discover/widgets/display/user_avatar.dart';
import 'package:dish_discover/widgets/display_with_input/like_save_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/user.dart';

class UserHeader extends ConsumerWidget {
  final ChangeNotifierProvider<User> userProvider;
  const UserHeader({super.key, required this.userProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(userProvider);

    return Flex(
        direction: Axis.vertical,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserAvatar(username: user.username, image: user.image),
          Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                  child: Text(user.description,
                      textAlign: TextAlign.center,
                      maxLines: 50,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis))),
          LikeSaveIndicator(
              likeButtonEnabled: true,
              likeCount: user.likesTotal,
              onLikePressed: null,
              saveButtonEnabled: true,
              saveCount: user.savesTotal,
              onSavePressed: null,
              center: true),
          const Divider(height: 2)
        ]);
  }
}
