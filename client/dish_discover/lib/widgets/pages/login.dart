import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';

import '../../entities/app_state.dart';
import '../../entities/user.dart';
import '../dialogs/custom_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(children: [
                  Image.asset('assets/images/logo.png', scale: 0.7),
                  Center(
                      child: Column(children: [
                    Text(errorMessage ?? ""),
                    CustomTextField(
                        controller: usernameController, hintText: 'Username'),
                    CustomTextField(
                        controller: passwordController,
                        hintText: 'Password',
                        obscure: true),
                    Align(
                        widthFactor: 200,
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                            child: Text('Recover password',
                                style: textStyle.merge(const TextStyle(
                                    decoration: TextDecoration.underline))),
                            onPressed: () => CustomDialog.callDialog(
                                context,
                                "Recover password",
                                "",
                                null,
                                CustomTextField(
                                    controller: TextEditingController(),
                                    hintText: "Email"),
                                "Send email",
                                () => {}))),
                    Align(
                        widthFactor: 200,
                        alignment: Alignment.bottomRight,
                        child: OutlinedButton(
                            child: Text('Login', style: textStyle),
                            onPressed: () {
                              AppState.currentUser = User(
                                  username: usernameController.text,
                                  isModerator: true);
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  '/dashboard',
                                  (route) => (route.toString() == '/'));
                            }))
                  ])),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(children: [
                        const Text("Don't have an account?"),
                        OutlinedButton(
                            child: const Text("Register"),
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/register'))
                      ]))
                ]))));
  }
}
