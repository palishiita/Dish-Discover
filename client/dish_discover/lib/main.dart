import 'package:dish_discover/widgets/pages/edit_recipe.dart';
import 'package:dish_discover/widgets/pages/login.dart';
import 'package:dish_discover/widgets/pages/main/main.dart';
import 'package:dish_discover/widgets/pages/register.dart';
import 'package:dish_discover/widgets/pages/settings.dart';
import 'package:dish_discover/widgets/pages/user.dart';
import 'package:dish_discover/widgets/pages/view_recipe.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';

import 'entities/user.dart';

void main() {
  runApp(DishDiscoverApp());
}

class DishDiscoverApp extends StatelessWidget {
  User dummyUser = User(username: 'Dummy', isModerator: true);
  DishDiscoverApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'DishDiscover', theme: appTheme, routes: {
      '/': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/dashboard': (context) => MainPage(currentUser: dummyUser),
      '/settings': (context) => const SettingsPage(),
      '/user': (context) => const UserPage(userId: 0),
      '/me': (context) => const UserPage(userId: -1),
      '/recipe': (context) => const ViewRecipePage(recipeId: 0),
      '/edit': (context) => const EditRecipePage(recipeId: 0)
    });
  }
}
