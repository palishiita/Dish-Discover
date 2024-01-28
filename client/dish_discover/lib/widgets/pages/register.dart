import 'package:dish_discover/entities/app_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entities/user.dart';
import '../dialogs/terms_dialog.dart';
import '../inputs/custom_text_field.dart';
import '../style/style.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = "/register";
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
            child: AppState.currentUser != null
                ? Center(
                    child: Column(children: [
                    const Text('Already logged in.'),
                    OutlinedButton(
                        child: Text('Return to Home Page', style: textStyle),
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                '/home', (route) => (route.toString() == '/')))
                  ]))
                : Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
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
                              onPressed: () async {
                                bool error = false;
                                // TODO register account and log in
                                if (passwordController.text.compareTo(
                                        repeatPasswordController.text) !=
                                    0) {
                                  error = true;
                                } else {
                                  // await User.addUser(User(
                                  //     username: usernameController.text,
                                  //     email: emailController.text,
                                  //     password: passwordController.text));
                                  // TODO check for errors messages
                                }

                                if (error) {
                                  // TODO show errors message
                                }

                                // TODO get user data
                                if (kDebugMode) {
                                  AppState.currentUser = User(
                                      username:
                                          "${usernameController.text}_debug",
                                      email: emailController.text,
                                      description: 'Some description',
                                      isModerator: true,
                                      password: passwordController.text);
                                }
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/home',
                                    (route) => (route.toString() == '/'));
                                Navigator.of(context).pushNamed('/tutorial');
                              }))
                    ]))),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: TextButton(
              child: const Text(
                  "By registering you agree to our Terms & Conditions",
                  style: TextStyle(
                      fontSize: 11, decoration: TextDecoration.underline)),
              onPressed: () => TermsDialog.callDialog(context)),
        ));
  }
}
