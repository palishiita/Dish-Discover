import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../entities/recipe.dart';
import '../dialogs/custom_dialog.dart';
import '../pages/edit_recipe.dart';
import '../pages/payment.dart';
import 'custom_text_field.dart';

enum PopupMenuAction {
  share(name: 'Share'),
  edit(name: 'Edit'),
  report(name: 'Report'),
  ban(name: 'Ban'),
  delete(name: 'Delete'),
  boost(name: 'Boost visibility');

  const PopupMenuAction({required this.name});
  final String name;

  static void shareAction(
      BuildContext context, String title, String message, String url) async {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      bool? result =
          await FlutterShare.share(title: title, text: message, linkUrl: url);

      if (result != null && result) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('\u{2713}  Content shared!')));
      }
    } else {
      await Clipboard.setData(ClipboardData(text: url));
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('\u{2713}  URL copied to clipboard!')));
    }
  }

  static void editAction(BuildContext context, int recipeId,
      ChangeNotifierProvider<Recipe> recipeProvider) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => EditRecipePage(
            recipeId: recipeId, recipeProvider: recipeProvider)));
  }

  static void reportAction(BuildContext context, int? recipeId, int? commentId,
      String? violatorId) async {
    assert(recipeId != null || commentId != null || violatorId != null);
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
        () {});
  }

  static void banAction(BuildContext context, int? recipeId, int? commentId,
      String? violatorId) async {
    assert(recipeId != null || commentId != null || violatorId != null);
    CustomDialog.callDialog(
        context,
        'Ban recipe',
        '',
        null,
        Column(children: [
          CustomTextField(
              controller: TextEditingController(),
              hintText: 'Password',
              obscure: true)
        ]),
        'Ban',
        () {});
  }

  static void deleteAction(BuildContext context, int recipeId) async {
    CustomDialog.callDialog(
      context,
      'Delete recipe',
      'Deletion is irreversible!',
      null,
      CustomTextField(
          controller: TextEditingController(),
          hintText: 'Password',
          obscure: true),
      'Delete',
      () {
        // TODO delete recipe
      },
    );
  }

  static void boostAction(BuildContext context) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const PaymentPage(buyingPremium: false)));
  }
}

class PopupMenu extends StatelessWidget {
  final PopupMenuAction action1;
  final void Function()? onPressed1;
  final PopupMenuAction action2;
  final void Function()? onPressed2;

  const PopupMenu(
      {super.key,
      required this.action1,
      required this.onPressed1,
      required this.action2,
      required this.onPressed2});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<PopupMenuAction>(
        initialValue: null,
        onSelected: (PopupMenuAction action) {},
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<PopupMenuAction>>[
              PopupMenuItem<PopupMenuAction>(
                value: action1,
                onTap: onPressed1,
                child: Text(action1.name, overflow: TextOverflow.fade),
              ),
              PopupMenuItem<PopupMenuAction>(
                value: action2,
                onTap: onPressed2,
                child: Text(action2.name, overflow: TextOverflow.fade),
              )
            ]);
  }
}
