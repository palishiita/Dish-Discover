import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/app_state.dart';
import '../../entities/recipe.dart';
import '../../entities/user.dart';
import '../display/tab_title.dart';
import '../display/user_header.dart';
import '../display_with_input/recipe_card.dart';
import '../inputs/popup_menu.dart';

class UserPage extends ConsumerWidget {
  final ChangeNotifierProvider<User> userProvider;
  const UserPage({super.key, required this.userProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(userProvider);
    bool isCurrentUser = (user.username == AppState.currentUser!.username);

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: appBarHeight,
            scrolledUnderElevation: 0.0,
            title: TabTitle(title: user.username ?? 'null'),
            centerTitle: true,
            leading: const BackButton(),
            actions: [
              isCurrentUser
                  ? IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () =>
                          Navigator.of(context).pushNamed("/settings"))
                  : PopupMenu(
                      action1: PopupMenuAction.share,
                      action2: AppState.currentUser!.isModerator
                          ? PopupMenuAction.ban
                          : PopupMenuAction.report)
            ]),
        body: Column(children: [
          UserHeader(userProvider: userProvider),
          RecipeList(recipes: user.addedRecipes ?? <Recipe>[])
        ]));
  }
}
