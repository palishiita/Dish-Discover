import 'package:flutter/material.dart';

class LoadingIndicator extends StatefulWidget {
  final Duration timeout;
  const LoadingIndicator({super.key, required this.timeout});

  @override
  State<StatefulWidget> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> {
  late DateTime start;
  @override
  void initState() {
    super.initState();
    start = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    Duration diff = DateTime.now().difference(start);
    return CircularProgressIndicator(
        value: (diff.inMicroseconds) / widget.timeout.inMicroseconds);
  }
}
