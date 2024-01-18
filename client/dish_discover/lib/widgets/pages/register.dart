import 'package:flutter/material.dart';

import '../inputs/custom_text_field.dart';
import '../style/style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                          onPressed: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil('/dashboard',
                                  (route) => (route.toString() == '/'))))
                ]))));
  }
}
