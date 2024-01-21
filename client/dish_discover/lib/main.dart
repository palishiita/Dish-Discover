import 'package:dish_discover/widgets/pages/edit_recipe.dart';
import 'package:dish_discover/widgets/pages/home.dart';
import 'package:dish_discover/widgets/pages/login.dart';
import 'package:dish_discover/widgets/pages/register.dart';
import 'package:dish_discover/widgets/pages/search.dart';
import 'package:dish_discover/widgets/pages/settings.dart';
import 'package:dish_discover/widgets/pages/user.dart';
import 'package:dish_discover/widgets/pages/view_recipe.dart';
import 'package:dish_discover/widgets/style/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'entities/app_state.dart';
import 'entities/recipe.dart';
import 'entities/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: DishDiscoverApp()));
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
          '/search': (context) => SearchPage(
              searchPhrase:
                  ModalRoute.of(context)?.settings.arguments as String),
          //'/user': (context) => const UserPage(user),
          '/me': (context) => UserPage(
              userProvider:
                  ChangeNotifierProvider<User>((ref) => AppState.currentUser!)),
          '/recipe': (context) => ViewRecipePage(
              recipeProvider:
                  ChangeNotifierProvider<Recipe>((ref) => Recipe())),
          '/edit': (context) => EditRecipePage(
              recipeProvider: ChangeNotifierProvider<Recipe>((ref) => Recipe()))
        });
  }
}
