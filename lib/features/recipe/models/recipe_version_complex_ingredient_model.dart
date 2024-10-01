class RecipeVersionComplexIngredient {
  RecipeVersionComplexIngredient({
    required this.id,
    // Points to the recipe version which calls for this complex ingredient
    required this.parentRecipeVersionId,
    // Points to the recipe version which defines this complex ingredient
    required this.childRecipeVersionId,
    required this.qty,
    required this.unit,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecipeVersionComplexIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeVersionComplexIngredient(
      id: json['id']! as String,
      parentRecipeVersionId: json['parentRecipeVersionId']! as String,
      childRecipeVersionId: json['childRecipeVersionId']! as String,
      qty: json['qty']! as int,
      unit: json['unit']! as String,
      createdAt: json['createdAt']! as String,
      updatedAt: json['updatedAt']! as String,
    );
  }
  final String id;
  final String parentRecipeVersionId;
  final String childRecipeVersionId;
  final int qty;
  final String unit;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentRecipeVersionId': parentRecipeVersionId,
      'childRecipeVersionId': childRecipeVersionId,
      'qty': qty,
      'unit': unit,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
