import 'package:dish_discover/widgets/small/tab_title.dart';
import 'package:flutter/material.dart';

class TermsDialog extends StatelessWidget {
  /// Simple Material dialog for confirmation with custom message.
  /// On cancel or click away, closes the dialog. On confirm, executes onConfirm.
  const TermsDialog({super.key});

  /// Calls a simple Material dialog for confirmation with custom message.
  /// On cancel or click away, closes the dialog. On confirm, executes onConfirm.
  static void callDialog(BuildContext context) {
    showBottomSheet(
        context: context, builder: (context) => const TermsDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const TabTitle(title: "Terms & Conditions"),
      Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: const Text("Terms..."),
      )
    ]);
  }
}
