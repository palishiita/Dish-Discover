import 'package:dish_discover/entities/app_state.dart';
import 'package:dish_discover/widgets/display/validation_message.dart';
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
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
  }

  void register() async {
    setState(() {
      errorMessage = null;
    });

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Registering...')));

    String? error;

    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        repeatPasswordController.text.isEmpty) {
      error = "All fields are required";
    } else if (passwordController.text
            .compareTo(repeatPasswordController.text) !=
        0) {
      error = "Passwords do not match";
    } else {
      error = await User.register(usernameController.text,
          passwordController.text, emailController.text);

      if (kDebugMode) {
        error = null;
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Logging in...')));

      if (error == null) {
        await User.login(usernameController.text, passwordController.text);
      }
    }
    ScaffoldMessenger.of(context).clearSnackBars();

    if (error == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/home', (route) => (route.toString() == '/'));
      Navigator.of(context).pushNamed('/tutorial');
    } else {
      setState(() {
        errorMessage = "Error: ${error!.trim()}!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (AppState.currentUser != null) {
      Future.microtask(
          () => Navigator.of(context).pushReplacementNamed("/home"));
    }

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: appBarHeight,
            scrolledUnderElevation: 0.0,
            leading: const BackButton()),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/logo.png', scale: 0.7),
                      errorMessage == null
                          ? Container()
                          : ValidationMessage(message: errorMessage!),
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
                              onPressed: register))
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
