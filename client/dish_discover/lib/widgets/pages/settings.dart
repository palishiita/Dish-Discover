import 'package:dish_discover/widgets/dialogs/terms_dialog.dart';
import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:dish_discover/widgets/pages/payment.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';

import '../../entities/app_state.dart';
import '../dialogs/custom_dialog.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: appBarHeight,
            scrolledUnderElevation: 0.0,
            leading: const BackButton()),
        body: ListView(children: [
          ListTile(
              title: const Text("Buy Premium"),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      const PaymentPage(buyingPremium: true)))),
          ListTile(
              title: const Text("Change email"),
              onTap: () => CustomDialog.callDialog(
                  context,
                  "Change email",
                  "",
                  null,
                  CustomTextField(
                      controller: textController, hintText: 'Email'),
                  "Change",
                  () {})),
          ListTile(
              title: const Text("Change password"),
              onTap: () => CustomDialog.callDialog(
                  context,
                  "Change password",
                  "",
                  null,
                  CustomTextField(
                      controller: textController,
                      hintText: 'Password',
                      obscure: true),
                  "Change",
                  () {})),
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
              onTap: () => CustomDialog.callDialog(
                      context,
                      "Delete account",
                      "",
                      null,
                      CustomTextField(
                          controller: textController,
                          hintText: 'Password',
                          obscure: true),
                      "Delete", () {
                    AppState.currentUser = null;
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => route.isFirst);
                  })),
        ]));
  }
}
