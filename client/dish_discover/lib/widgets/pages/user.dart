import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../entities/app_state.dart';
import '../../entities/recipe.dart';
import '../../entities/user.dart';
import '../dialogs/custom_dialog.dart';
import '../display/recipe_list.dart';
import '../display/tab_title.dart';
import '../display/user_header.dart';
import '../inputs/custom_text_field.dart';
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
                      onPressed1: () async => await FlutterShare.share(
                          title: 'Share user',
                          text: user.username,
                          linkUrl: '[link]'), // TODO link
                      action2: AppState.currentUser!.isModerator
                          ? PopupMenuAction.ban
                          : PopupMenuAction.report,
                      onPressed2: () => AppState.currentUser!.isModerator
                          ? {
                              CustomDialog.callDialog(
                                  context,
                                  'Ban recipe',
                                  '',
                                  null,
                                  Column(children: [
                                    CustomTextField(
                                        controller: TextEditingController(),
                                        hintText: 'Password',
                                        obscure: true),
                                    CustomTextField(
                                        controller: TextEditingController(),
                                        hintText: 'Repeat password',
                                        obscure: true)
                                  ]),
                                  'Ban',
                                  () {})
                            }
                          : {
                              CustomDialog.callDialog(
                                  context,
                                  'Report recipe',
                                  '',
                                  null,
                                  Column(children: [
                                    CustomTextField(
                                        controller: TextEditingController(),
                                        hintText: 'Reason',
                                        obscure: true)
                                  ]),
                                  'Report',
                                  () {})
                            })
            ]),
        body: Column(children: [
          UserHeader(userProvider: userProvider),
          RecipeList(
              getRecipes: () =>
                  Future<List<Recipe>>(() => (user.addedRecipes ?? <Recipe>[])))
        ]));
  }
}
