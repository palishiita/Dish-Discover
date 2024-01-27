import 'package:flutter/material.dart';

import '../display/tab_title.dart';

class FilterSideMenu extends StatefulWidget {
  const FilterSideMenu({super.key});

  @override
  State<StatefulWidget> createState() => _FilterSideMenuState();
}

class _FilterSideMenuState extends State<FilterSideMenu> {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(30.0))),
        child: Column(
          children: [TabTitle(title: 'Filter'), Text('...')],
        ));
  }
}
