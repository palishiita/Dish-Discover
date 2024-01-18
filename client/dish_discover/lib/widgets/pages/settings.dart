import 'package:dish_discover/widgets/dialogs/terms_dialog.dart';
import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:dish_discover/widgets/pages/buy.dart';
import 'package:flutter/material.dart';

import '../../entities/app_state.dart';
import '../dialogs/custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Scaffold(
        appBar: AppBar(),
        body: ListView(children: [
          ListTile(
              title: const Text("Buy Premium"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const BuyPage(buyingPremium: true)))),
          ListTile(
              title: const Text("Change email"),
              onTap: () => CustomDialog(
                  title: "Change email",
                  subtitle: "",
                  message: null,
                  buttonLabel: "Change",
                  onPressed: () {},
                  child: CustomTextField(
                      controller: textController, hintText: 'Email'))),
          ListTile(
              title: const Text("Change password"),
              onTap: () => CustomDialog(
                  title: "Change email",
                  subtitle: "",
                  message: null,
                  buttonLabel: "Change",
                  onPressed: () {},
                  child: CustomTextField(
                      controller: textController, hintText: 'Email'))),
          ListTile(
              title: const Text("Terms & Conditions"),
              onTap: () => TermsDialog.callDialog(context)),
          ListTile(
              title: const Text("Log out"),
              onTap: () {
                AppState.currentUser = null;
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/");
              }),
          ListTile(
              title: const Text("Delete account"),
              onTap: () => CustomDialog(
                  title: "Delete account",
                  subtitle: "",
                  message: null,
                  buttonLabel: "Delete",
                  onPressed: () {
                    AppState.currentUser = null;
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/");
                  },
                  child: CustomTextField(
                      controller: textController,
                      hintText: 'Password',
                      obscure: true))),
        ]));
  }
}
