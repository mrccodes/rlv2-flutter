class RecipeVersionCompleIngredient {
  RecipeVersionCompleIngredient({
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

  factory RecipeVersionCompleIngredient.fromJson(Map<String, String> json) {
    return RecipeVersionCompleIngredient(
      id: json['id']!,
      parentRecipeVersionId: json['parentRecipeVersionId']!,
      childRecipeVersionId: json['childRecipeVersionId']!,
      qty: int.parse(json['qty']!),
      unit: json['unit']!,
      createdAt: json['createdAt']!,
      updatedAt: json['updatedAt']!,

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
