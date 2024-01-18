import 'package:dish_discover/widgets/pages/edit_recipe.dart';
import 'package:dish_discover/widgets/pages/home.dart';
import 'package:dish_discover/widgets/pages/login.dart';
import 'package:dish_discover/widgets/pages/register.dart';
import 'package:dish_discover/widgets/pages/settings.dart';
import 'package:dish_discover/widgets/pages/view_recipe.dart';
import 'package:dish_discover/widgets/pages/view_user.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';

import 'entities/app_state.dart';

void main() {
  runApp(const DishDiscoverApp());
}

class DishDiscoverApp extends StatelessWidget {
  const DishDiscoverApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DishDiscover',
        theme: appThemeLight,
        routes: {
          '/': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/dashboard': (context) => HomePage(),
          '/settings': (context) => const SettingsPage(),
          //'/user': (context) => const UserPage(user),
          '/me': (context) => UserPage(user: AppState.currentUser!),
          '/recipe': (context) => const ViewRecipePage(recipeId: 0),
          '/edit': (context) => const EditRecipePage(recipeId: 0)
        });
  }
}
