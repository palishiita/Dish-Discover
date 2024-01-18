import 'package:flutter/cupertino.dart';

enum TagCategory { cuisine, difficulty, diet, expense }

class Tag extends ChangeNotifier {
  String? name;
  bool? isPredefined;
  TagCategory? category;
}
