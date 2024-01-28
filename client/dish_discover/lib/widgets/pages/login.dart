import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entities/app_state.dart';
import '../../entities/user.dart';
import '../dialogs/custom_dialog.dart';

class LoginPage extends StatefulWidget {
  static const routeName = "/";

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
        appBar:
            AppBar(toolbarHeight: appBarHeight, scrolledUnderElevation: 0.0),
        body: SingleChildScrollView(
            child: AppState.currentUser != null
                ? Center(
                    child: Column(children: [
                    const Text('Already logged in.', softWrap: true),
                    OutlinedButton(
                        child: Text('Return to Home Page', style: textStyle),
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                '/home', (route) => route.isFirst))
                  ]))
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Column(children: [
                      Image.asset('assets/images/logo.png', scale: 0.7),
                      Text(errorMessage ?? "", softWrap: true),
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
                              onPressed: () async {
                                String username = usernameController.text;
                                String password = passwordController.text;
                                if (kDebugMode) {
                                  AppState.currentUser = User(
                                      username: username,
                                      password: password,
                                      email: '');
                                }

                                // TODO await login validation and return token

                                // TODO get current user's full data
                                // AppState.currentUser =
                                //     await User.getUser(username);

                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/home',
                                    (route) => (route.toString() == '/'));
                              }))
                    ])))),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Text("Don't have an account?")),
                  OutlinedButton(
                      child: const Text("Register"),
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/register'))
                ])));
  }
}
