import 'package:flutter/cupertino.dart';

enum TagCategory {
  cuisine,
  difficulty,
  diet,
  expense,
  ingredient,
  time,
}


class Tag {
  String? name;
  bool? isPredefined;
  TagCategory? category;

  Tag(
      this.isPredefined,
      this.name,
      this.category
      );
}

class PreferredTag {
  int? userId;
  String? tagName;
  double? weight;

  PreferredTag(
      this.userId,
      this.tagName,
      this.weight,
      );
}
