import 'package:dish_discover/entities/user.dart';
import 'package:dish_discover/widgets/pages/main/moderation_tab.dart';
import 'package:dish_discover/widgets/pages/main/recommended_tab.dart';
import 'package:dish_discover/widgets/pages/main/saved_tab.dart';
import 'package:flutter/material.dart';

import '../../style/style.dart';

class MainPageTab extends StatelessWidget {
  final String title;
  final Widget body;
  final FloatingActionButton? fab;

  const MainPageTab(
      {super.key, required this.title, required this.body, this.fab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title, style: textStyle), centerTitle: true),
        floatingActionButton: fab,
        body: body);
  }
}

class MainPage extends StatelessWidget {
  final User currentUser;
  const MainPage({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: currentUser.isModerator ? 3 : 2,
        child: Scaffold(
            appBar: AppBar(
                title: Image.asset('assets/images/logo.png'),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () => Navigator.pushNamed(context, '/me'),
                      icon: Icon(icons['account']))
                ],
                bottom: PreferredSize(
                    preferredSize: Size(100, 10),
                    child: Text('Searchbox'))), //,
            body: TabBarView(
              children: currentUser.isModerator
                  ? [
                      const RecommendedTab(),
                      const SavedTab(),
                      const ModerationTab()
                    ]
                  : [const RecommendedTab(), const SavedTab()],
            ),
            bottomNavigationBar: TabBar(
                tabs: List.filled(
                    currentUser.isModerator ? 3 : 2, Tab(text: '.')))));
  }
}
