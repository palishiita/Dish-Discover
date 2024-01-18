import 'package:dish_discover/widgets/inputs/custom_text_field.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';

import '../../entities/app_state.dart';
import '../../entities/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;

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
                  CustomTextField(
                      controller: usernameController, hintText: 'Username'),
                  CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscure: true),
                  Align(
                      widthFactor: 200,
                      alignment: Alignment.centerLeft,
                      child: Text('Recover password',
                          style: textStyle.merge(const TextStyle(
                              decoration: TextDecoration.underline)))),
                  Align(
                      widthFactor: 200,
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          child: Text('Login', style: textStyle),
                          onPressed: () {
                            AppState.currentUser = User(
                                username: usernameController.text,
                                isModerator: true);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/dashboard',
                                (route) => (route.toString() == '/'));
                          }))
                ]))));
  }
}
