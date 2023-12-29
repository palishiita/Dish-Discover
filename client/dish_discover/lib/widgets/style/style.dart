import 'package:flutter/material.dart';

ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
  useMaterial3: true,
);

Map<String, IconData> icons = {
  'settings': Icons.settings_rounded,
  'account': Icons.account_circle_rounded,
  'recommended': Icons.auto_awesome,
  'saved': Icons.book,
  'moderation': Icons.sticky_note_2_outlined,
  'report': Icons.flag_outlined,
  'share': Icons.share_rounded,
  'edit': Icons.edit_outlined,
  'add': Icons.add,
  'delete': Icons.delete_rounded,
  'upload': Icons.upload_file,
  'reject': Icons.close,
  'accept': Icons.check,
  'save_empty': Icons.bookmark_add_outlined,
  'save_full': Icons.bookmark_add_rounded,
  'like_empty': Icons.favorite_border_rounded,
  'like_full': Icons.favorite
};

TextStyle textStyle = const TextStyle();
