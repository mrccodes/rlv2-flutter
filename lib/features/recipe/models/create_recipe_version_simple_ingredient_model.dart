class CreateRecipeVersionSimpleIngredient {
  CreateRecipeVersionSimpleIngredient({
    required this.simpleIngredientId,
    required this.recipeVersionId,
    required this.qty,
    required this.unitId,
  });

  factory CreateRecipeVersionSimpleIngredient.fromJson(
    Map<String, dynamic> json,
  ) {
    return CreateRecipeVersionSimpleIngredient(
      simpleIngredientId: json['simpleIngredientId'] as String,
      recipeVersionId: json['recipeVersionId'] as String,
      qty: json['qty'] as num,
      unitId: json['unitId'] as String,
    );
  }

  final String simpleIngredientId;
  final String recipeVersionId;
  final num qty;
  final String unitId;

  Map<String, dynamic> toJson() {
    return {
      'simpleIngredientId': simpleIngredientId,
      'recipeVersionId': recipeVersionId,
      'qty': qty,
      'unitId': unitId,
    };
  }
}
