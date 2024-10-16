class ComplexIngredient {
  ComplexIngredient({
    required this.id,
    // Points to the recipe version which calls for this complex ingredient
    required this.parentRecipeVersionId,
    // Points to the recipe version which defines this complex ingredient
    required this.childRecipeVersionId,
    required this.childRecipeName,
    required this.qty,
    required this.unit,
    required this.createdAt,
    required this.updateAt,
  });

  factory ComplexIngredient.fromJson(Map<String, dynamic> json) {
    return ComplexIngredient(
      id: json['id'] as String,
      parentRecipeVersionId: json['parentRecipeVersionId'] as String,
      childRecipeVersionId: json['childRecipeVersionId'] as String,
      childRecipeName: json['childRecipeName'] as String,
      qty: json['qty'] as int,
      unit: json['unit'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updateAt: DateTime.parse(json['updateAt'] as String),
    );
  }

  final String id;
  final String parentRecipeVersionId;
  final String childRecipeVersionId;
  final String childRecipeName;
  final int qty;
  final String unit;
  final DateTime createdAt;
  final DateTime updateAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'parentRecipeVersionId': parentRecipeVersionId,
      'childRecipeVersionId': childRecipeVersionId,
      'childRecipeName': childRecipeName,
      'qty': qty,
      'unit': unit,
      'createdAt': createdAt.toIso8601String(),
      'updateAt': updateAt.toIso8601String(),
    };
  }
}
