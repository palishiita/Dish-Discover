import 'package:dish_discover/widgets/small/tab_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/app_state.dart';
import '../../entities/recipe.dart';
import '../../entities/user.dart';
import '../small/recipe_card.dart';
import '../small/user_header.dart';

class UserPage extends ConsumerWidget {
  final ChangeNotifierProvider<User> userProvider;
  const UserPage({super.key, required this.userProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(userProvider);
    bool isCurrentUser = (user.username == AppState.currentUser!.username);

    return Scaffold(
        appBar: AppBar(
            title: TabTitle(title: user.username ?? 'null'),
            centerTitle: true,
            actions: [
              IconButton(
                  icon: Icon(isCurrentUser
                      ? Icons.settings
                      : Icons.more_horiz_rounded),
                  onPressed: () => isCurrentUser
                      ? Navigator.of(context).pushNamed("/settings")
                      : {
                          // TODO: show dropdown options Share and Report/Ban
                        })
            ]),
        body: Column(
          children: [
            UserHeader(userProvider: userProvider),
            Expanded(
                child: RecipeList(recipes: user.addedRecipes ?? <Recipe>[]))
          ],
        ));
  }
}
