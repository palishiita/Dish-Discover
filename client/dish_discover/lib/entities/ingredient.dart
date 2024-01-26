import 'package:http/http.dart' as http;
import 'dart:convert';

class Ingredient {
  int? id;
  String? name;
  int? quantity;
  int? caloricDensity;
  String? unit;

  Ingredient({
    this.id,
    this.name,
    this.quantity,
    this.caloricDensity,
    this.unit
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      quantity: json['amount'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': quantity,
      'unit': unit,
    };
  }

  Future<void> addIngredient(Ingredient ingredient) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/ingredients'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(ingredient.toJson()),
    );

    if (response.statusCode == 201) {
      print('Ingredient added successfully');
    } else {
      throw Exception('Failed to add ingredient, status code: ${response.statusCode}');
    }
  }

  Future<List<Ingredient>> getIngredients() async {
    final response = await http.get(Uri.parse('http://localhost:8000/api/ingredients'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['ingredients'];
      return data.map((item) => Ingredient.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load ingredients, status code: ${response.statusCode}');
    }
  }
}