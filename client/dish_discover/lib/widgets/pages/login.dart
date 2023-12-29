import 'package:dish_discover/widgets/common/text_input_box.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Image.asset('assets/images/logo.png', scale: 0.7),
      FormField(builder: (state) => const TextInputBox(hint: 'Username')),
      FormField(
          initialValue: 'Password',
          builder: (state) =>
              const TextInputBox(hint: 'Password', obscure: true)),
      Align(
          widthFactor: 200,
          alignment: Alignment.centerLeft,
          child: Text('Recover password',
              style: textStyle.merge(
                  const TextStyle(decoration: TextDecoration.underline)))),
      Align(
          widthFactor: 200,
          alignment: Alignment.bottomRight,
          child: TextButton(
              child: Text('Login', style: textStyle),
              onPressed: () => Navigator.of(context).pushNamedAndRemoveUntil(
                  '/dashboard', (route) => (route.toString() == '/'))))
    ])));
  }
}
