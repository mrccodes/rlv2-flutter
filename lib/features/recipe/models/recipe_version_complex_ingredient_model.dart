class RecipeVersionComplexIngredient {
  RecipeVersionComplexIngredient({
    required this.id,
    // Points to the recipe version which calls for this complex ingredient
    required this.parentRecipeVersionId,
    // Points to the recipe version which defines this complex ingredient
    required this.childRecipeVersionId,
    required this.childRecipeVersionNumber,
    required this.childRecipeName,
    required this.childRecipeId,
    required this.qty,
    required this.unitId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecipeVersionComplexIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeVersionComplexIngredient(
      id: json['id']! as String,
      parentRecipeVersionId: json['parentRecipeVersionId']! as String,
      childRecipeVersionId: json['childRecipeVersionId']! as String,
      childRecipeVersionNumber: json['childRecipeVersionNumber']! as int,
      childRecipeId: json['childRecipeId']! as String,
      childRecipeName: json['childRecipeName']! as String,
      qty: json['qty']! as int,
      unitId: json['unitId']! as String,
      createdAt: json['createdAt']! as String,
      updatedAt: json['updatedAt']! as String,
    );
  }
  final String id;
  final String parentRecipeVersionId;
  final String childRecipeVersionId;
  final int childRecipeVersionNumber;
  final String childRecipeName;
  final String childRecipeId;
  final int qty;
  final String unitId;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentRecipeVersionId': parentRecipeVersionId,
      'childRecipeVersionId': childRecipeVersionId,
      'childRecipeVersionNumber': childRecipeVersionNumber,
      'childRecipeName': childRecipeName,
      'childRecipeId': childRecipeId,
      'qty': qty,
      'unitId': unitId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
