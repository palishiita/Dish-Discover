import 'package:flutter/material.dart';

/// Theme data, frequently used colors and other layout details.
Color baseColor = Colors.orange[700]!;
Color likeColor = Colors.red[800]!;
Color saveColor = Colors.cyan;
Color imageShadowColor = const Color(0xff000000);

Color backgroundColor(BuildContext context) =>
    Theme.of(context).colorScheme.background;
Color buttonColor = baseColor;
Color gradientStartColor(BuildContext context) =>
    Theme.of(context).colorScheme.primary;
Color gradientEndColor(BuildContext context) =>
    Theme.of(context).colorScheme.inversePrimary;
Color containerColor(BuildContext context) =>
    Theme.of(context).colorScheme.onInverseSurface;
Color outerContainerColor(BuildContext context) =>
    Theme.of(context).colorScheme.surfaceVariant;

ThemeData appThemeLight = ThemeData(
    colorScheme: ColorScheme.fromSeed(
        seedColor: baseColor, brightness: Brightness.light),
    useMaterial3: true);

ThemeData appThemeDark = ThemeData(
    colorScheme:
        ColorScheme.fromSeed(seedColor: baseColor, brightness: Brightness.dark),
    useMaterial3: true);

TextStyle textStyle = const TextStyle();

double appBarHeight = 75;
