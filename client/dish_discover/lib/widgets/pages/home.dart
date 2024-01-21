import 'package:dish_discover/widgets/inputs/custom_search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entities/app_state.dart';
import '../../entities/user.dart';
import 'home_tabs/moderation_tab.dart';
import 'home_tabs/recommended_tab.dart';
import 'home_tabs/saved_tab.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key}) {
    if (kDebugMode && AppState.currentUser == null) {
      AppState.currentUser = User(username: "dummy", isModerator: true);
    }
    assert(AppState.currentUser != null);
  }

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        length: AppState.currentUser!.isModerator ? 3 : 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 50,
          scrolledUnderElevation: 0.0,
          title: const Text(
              'DishDiscover'), //Image.asset('assets/images/logo.png')),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => Navigator.pushNamed(context, '/me'),
                icon: const Icon(Icons.account_circle_rounded))
          ],
        ),
        body: Column(children: [
          const CustomSearchBar(),
          Expanded(
              child: TabBarView(
            controller: tabController,
            children: [const RecommendedTab(), const SavedTab()] +
                (AppState.currentUser!.isModerator
                    ? [const ModerationTab()]
                    : []),
          ))
        ]),
        bottomNavigationBar: TabBar(
            controller: tabController,
            tabs: List.filled(AppState.currentUser!.isModerator ? 3 : 2,
                const Tab(text: '.'))));
  }
}
