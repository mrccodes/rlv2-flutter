import 'package:rlv2_flutter/features/recipe/models/create_simple_ingredient_model.dart';

class SimpleIngredient extends CreateSimpleIngredient {
  SimpleIngredient({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required super.name,
    super.brand,
    super.origin,
  });

  factory SimpleIngredient.fromJson(Map<String, dynamic> json) {
    return SimpleIngredient(
      id: json['id']! as String,
      name: json['name']! as String,
      brand: json['brand'] as String?,
      origin: json['origin'] as String?,
      createdAt: json['createdAt']! as String,
      updatedAt: json['updatedAt']! as String,
    );
  }

  final String id;
  final String createdAt;
  final String updatedAt;

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'origin': origin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
