import 'package:dish_discover/widgets/display/tab_title.dart';
import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../entities/app_state.dart';
import '../../entities/comment.dart';
import '../../entities/recipe.dart';
import '../../entities/user.dart';
import '../display/user_avatar.dart';
import '../inputs/popup_menu.dart';
import '../pages/user.dart';

class CommentTile extends ConsumerWidget {
  final ChangeNotifierProvider<Comment> commentProvider;

  const CommentTile({super.key, required this.commentProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Comment comment = ref.watch(commentProvider);
    User author = User(username: comment.authorId, isModerator: false);

    return Padding(
        padding: const EdgeInsets.all(8),
        child: AspectRatio(
            aspectRatio: 3.5,
            child: Card(
                child: Column(children: [
              ListTile(
                  leading: UserAvatar(
                      image: author.image,
                      diameter: 30,
                      userProvider:
                          ChangeNotifierProvider<User>((ref) => author)),
                  title: GestureDetector(
                      onTap: author == null
                          ? null
                          : () => Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserPage(
                                  userProvider: ChangeNotifierProvider<User>(
                                      (ref) => author)))),
                      child: Text(author.username ?? 'null')),
                  trailing: PopupMenu(
                      action1: PopupMenuAction.share,
                      action2: AppState.currentUser!.isModerator
                          ? PopupMenuAction.ban
                          : PopupMenuAction.report)),
              const Divider(height: 1.0),
              const Align(
                  alignment: Alignment.topLeft,
                  child:
                      Padding(padding: EdgeInsets.all(15.0), child: Text('')))
            ]))));
  }
}

class CommentsBox extends ConsumerWidget {
  final TextEditingController commentController = TextEditingController();
  final ChangeNotifierProvider<Recipe> recipeProvider;
  CommentsBox({super.key, required this.recipeProvider});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Recipe recipe = ref.watch(recipeProvider);
    List<Comment> comments = recipe.comments ?? [];
    if (kDebugMode && comments.isEmpty) {
      comments = [
        Comment(
            authorId: 'Test_user',
            recipeId: 0,
            commentId: 0,
            content: '[Testing]')
      ];
    }

    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Card(
            child: Column(children: [
          const Align(
              alignment: Alignment.centerLeft,
              child: TabTitle(title: "Comments")),
          CustomTextField(
              controller: commentController,
              hintText: 'Comment',
              trailingAction: IconButton(
                  icon: const Icon(Icons.arrow_right_alt_rounded),
                  onPressed: () {
                    // TODO recipe add comment
                  })),
          Column(
              children: List.generate(
                  comments.length,
                  (index) => CommentTile(
                      commentProvider: ChangeNotifierProvider<Comment>(
                          (ref) => comments[index]))))
        ])));
  }
}
