import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? message;
  final Widget child;
  final String buttonLabel;
  final void Function() onPressed;

  /// Simple Material dialog for confirmation with custom message.
  /// On cancel or click away, closes the dialog. On confirm, executes onConfirm.
  const CustomDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.message,
      required this.child,
      required this.buttonLabel,
      required this.onPressed});

  /// Calls a simple Material dialog for confirmation with custom message.
  /// On cancel or click away, closes the dialog. On confirm, executes onConfirm.
  static void callDialog(
      BuildContext context,
      String title,
      String subtitle,
      Widget? message,
      Widget child,
      String buttonLabel,
      void Function() onPressed) {
    Navigator.of(context).push(DialogRoute(
        context: context,
        builder: (context) => CustomDialog(
            title: title,
            subtitle: subtitle,
            message: message,
            buttonLabel: buttonLabel,
            onPressed: onPressed,
            child: child)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            child: AlertDialog(
                titleTextStyle: Theme.of(context).textTheme.labelLarge,
                title: Text(title),
                content: Column(
                    children: [Text(subtitle), message ?? Container(), child]),
                actions: [
                  Center(
                      child: OutlinedButton(
                          child: Text(buttonLabel),
                          onPressed: () {
                            Navigator.of(context).pop();
                            onPressed();
                          }))
                ])));
  }
}
