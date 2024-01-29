import 'package:flutter/material.dart';

class ValidationMessage extends StatelessWidget {
  final String message;
  final bool isError;
  const ValidationMessage(
      {super.key, required this.message, this.isError = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: RawChip(
            tapEnabled: false,
            backgroundColor: Theme.of(context).colorScheme.inverseSurface,
            label: Text(message,
                softWrap: true,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onInverseSurface),
                overflow: TextOverflow.visible),
            avatar: Icon(isError ? Icons.error : Icons.check_circle_rounded,
                color: isError
                    ? Theme.of(context).colorScheme.error
                    : Colors.green)));
  }
}
