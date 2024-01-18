import 'package:flutter/material.dart';

import '../../entities/user.dart';

class UserPage extends StatelessWidget {
  final User user;
  const UserPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => Navigator.of(context).pushNamed("/settings"))
        ]),
        body: Center(child: Text("User ${user.username}")));
  }
}
