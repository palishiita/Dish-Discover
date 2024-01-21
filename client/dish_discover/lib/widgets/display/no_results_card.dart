import 'package:flutter/material.dart';

class NoResultsCard extends StatelessWidget {
  const NoResultsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: AspectRatio(
            aspectRatio: 1.2,
            child: Card(
                child: Center(
                    child:
                        Text("No content found :(\nYou might be offline")))));
  }
}
