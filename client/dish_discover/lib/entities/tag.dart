import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      json['isPredefined'],
      json['name'],
      TagCategory.values[json['category']],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isPredefined': isPredefined,
      'name': name,
      'category': category?.index,
    };
  }

  Future<void> addTag(Tag tag) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/tags'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tag.toJson()),
    );

    if (response.statusCode == 201) {
      print('Tag added successfully');
    } else {
      throw Exception('Failed to add tag, status code: ${response.statusCode}');
    }
  }

  Future<List<Tag>> getTags() async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/tags'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['tags'];
      return data.map((item) => Tag.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load tags, status code: ${response.statusCode}');
    }
  }
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
