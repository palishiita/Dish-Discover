import 'package:flutter/material.dart';

import '../dialogs/terms_dialog.dart';
import '../inputs/custom_text_field.dart';
import '../style/style.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            toolbarHeight: appBarHeight,
            scrolledUnderElevation: 0.0,
            leading: const BackButton()),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(children: [
                  Image.asset('assets/images/logo.png', scale: 0.7),
                  CustomTextField(
                      controller: usernameController, hintText: 'Username'),
                  CustomTextField(
                      controller: emailController, hintText: 'Email'),
                  CustomTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscure: true),
                  CustomTextField(
                      controller: repeatPasswordController,
                      hintText: 'Repeat password',
                      obscure: true),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: OutlinedButton(
                          child: Text('Register', style: textStyle),
                          onPressed: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil('/dashboard',
                                  (route) => (route.toString() == '/')))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                        child: const Text(
                            "By registering you agree to our Terms & Conditions",
                            style: TextStyle(
                                fontSize: 11,
                                decoration: TextDecoration.underline)),
                        onPressed: () => TermsDialog.callDialog(context)),
                  )
                ]))));
  }
}
