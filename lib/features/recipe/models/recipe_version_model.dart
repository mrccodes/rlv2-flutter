class RecipeVersion {
  RecipeVersion({
    required this.id,
    required this.recipeId,
    required this.versionNumber,
    required this.deleted,
    required this.difficulty,
    required this.createdAt,
    required this.updatedAt,
    required this.servings,
    this.description,
    this.cookTime,
    this.prepTime,
    this.rating,
    this.calories,
    this.fat,
    this.saturatedFat,
    this.cholesterol,
    this.sodium,
    this.carbohydrates,
    this.fiber,
    this.protein,
  });

  factory RecipeVersion.fromJson(Map<String, dynamic> json) {
    return RecipeVersion(
      id: json['id']! as String,
      recipeId: json['recipeId']! as String,
      versionNumber: json['versionNumber']! as int,
      deleted: json['deleted']! as bool,
      difficulty: json['difficulty']! as String,
      servings: json['servings']! as int,
      description: json['description'] as String?,
      cookTime: json['cookTime'] as int?,
      prepTime: json['prepTime'] as int?,
      rating: json['rating'] as int?,
      calories: json['calories'] as int?,
      fat: json['fat'] as int?,
      protein: json['protein'] as int,
      carbohydrates: json['carbohydrates'] as int,
      saturatedFat: json['saturatedFat'] as int,
      cholesterol: json['cholesterol'] as int,
      sodium: json['sodium'] as int,
      fiber: json['fiber'] as int,
      createdAt: json['createdAt']! as String,
      updatedAt: json['updatedAt']! as String,
    );
  }
  final String id;
  final String recipeId;
  final int versionNumber;
  final bool deleted;
  final String difficulty;
  final String? description;
  final int? cookTime;
  final int? prepTime;
  final int? servings;
  final int? rating;
  final int? calories;
  final int? fat;
  final int? protein;
  final int? carbohydrates;
  final int? saturatedFat;
  final int? cholesterol;
  final int? sodium;
  final int? fiber;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipeId': recipeId,
      'versionNumber': versionNumber,
      'deleted': deleted,
      'difficulty': difficulty,
      'description': description,
      'cookTime': cookTime,
      'prepTime': prepTime,
      'servings': servings,
      'rating': rating,
      'calories': calories,
      'fat': fat,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'saturatedFat': saturatedFat,
      'cholesterol': cholesterol,
      'sodium': sodium,
      'fiber': fiber,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
