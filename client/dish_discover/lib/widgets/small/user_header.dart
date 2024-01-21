import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/user.dart';

class UserHeader extends ConsumerWidget {
  ChangeNotifierProvider<User> userProvider;
  UserHeader({super.key, required this.userProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(userProvider);

    return ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 100),
        child: const Center(child: Text("Image=?? Likes=?? Saves=??")));
  }
}
