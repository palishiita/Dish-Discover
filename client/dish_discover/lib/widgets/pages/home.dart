import 'package:dish_discover/widgets/inputs/custom_search_bar.dart';
import 'package:dish_discover/widgets/pages/user.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../entities/app_state.dart';
import '../../entities/user.dart';
import 'home_tabs/moderation_tab.dart';
import 'home_tabs/recommended_tab.dart';
import 'home_tabs/saved_tab.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";

  HomePage({super.key}) {
    if (kDebugMode && AppState.currentUser == null) {
      AppState.currentUser =
          User(username: "dummy", isModerator: true, password: '', email: '');

      // TODO get current user's full data
      // AppState.currentUser =
      //     await User.getUser(username);
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
            toolbarHeight: appBarHeight,
            scrolledUnderElevation: 0.0,
            title: Text('DishDiscover',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium), //Image.asset('assets/images/logo.png')),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          UserPage(username: AppState.currentUser!.username))),
                  icon: const Icon(Icons.account_circle_rounded))
            ]),
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
          padding: const EdgeInsets.symmetric(horizontal: 120),
          controller: tabController,
          tabs: List.filled(
              AppState.currentUser!.isModerator ? 3 : 2,
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 15),
                  child: Icon(Icons.circle, size: 13))),
          indicatorColor: baseColor.withAlpha(0),
          labelColor: buttonColor,
          unselectedLabelColor: Colors.blueGrey.withAlpha(0x52),
        ));
  }
}
