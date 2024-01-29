import 'package:dish_discover/widgets/display/user_avatar.dart';
import 'package:dish_discover/widgets/display_with_input/like_save_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/app_state.dart';
import '../../entities/user.dart';

class UserHeader extends ConsumerWidget {
  final ChangeNotifierProvider<User> userProvider;
  const UserHeader({super.key, required this.userProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(userProvider);
    bool isCurrentUser = user.username == AppState.currentUser!.username;
    int likeCount = 0; //user.likes();
    int saveCount = 0; //user.saves();

    return ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 170),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          UserAvatar(username: user.username, image: user.image),
          Center(
              child: Text(user.description,
                  softWrap: true, overflow: TextOverflow.fade)),
          LikeSaveIndicator(
              likeButtonEnabled: true,
              likeCount: likeCount,
              onLikePressed: null,
              saveButtonEnabled: true,
              saveCount: saveCount,
              onSavePressed: null,
              center: true),
          const Divider()
        ]));
  }
}
