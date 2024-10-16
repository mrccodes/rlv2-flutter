class RecipeVersionSimpleIngredient {
  RecipeVersionSimpleIngredient({
    required this.id,
    required this.simpleIngredientId,
    required this.recipeVersionId,
    required this.qty,
    required this.unitId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecipeVersionSimpleIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeVersionSimpleIngredient(
      id: json['id'] as String,
      simpleIngredientId: json['simpleIngredientId'] as String,
      recipeVersionId: json['recipeVersionId'] as String,
      qty: json['qty'] as int,
      unitId: json['unitId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  final String id;
  final String simpleIngredientId;
  final String recipeVersionId;
  final int qty;
  final String unitId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'simpleIngredientId': simpleIngredientId,
      'recipeVersionId': recipeVersionId,
      'qty': qty,
      'unitId': unitId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
