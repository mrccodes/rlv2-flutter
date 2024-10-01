class RecipeVersion {
  RecipeVersion({
    required this.id,
    required this.recipeId,
    required this.versionNumber,
    required this.deleted,
    required this.difficulty,
    required this.description,
    required this.cookTime,
    required this.prepTime,
    required this.servings,
    required this.rating,
    required this.calories,
    required this.fat,
    required this.protein,
    required this.carbs,
    required this.saturatedFat,
    required this.cholesterol,
    required this.sodium,
    required this.fiber,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RecipeVersion.fromJson(Map<String, String> json) {
    return RecipeVersion(
      id: json['id']!,
      recipeId: json['recipeId']!,
      versionNumber: int.parse(json['versionNumber']!),
      deleted: bool.parse(json['deleted']!),
      difficulty: json['difficulty']!,
      description: json['description'],
      cookTime: json['cookTime'] != null ? int.parse(json['cookTime']!) : null,
      prepTime: json['prepTime'] != null ? int.parse(json['prepTime']!) : null,
      servings: json['servings'] != null ? int.parse(json['servings']!) : null,
      rating: json['rating'] != null ? int.parse(json['rating']!) : null,
      calories: json['calories'] != null ? int.parse(json['calories']!) : null,
      fat: json['fat'] != null ? int.parse(json['fat']!) : null,
      protein: json['protein'] != null ? int.parse(json['protein']!) : null,
      carbs: json['carbs'] != null ? int.parse(json['carbs']!) : null,
      saturatedFat: json['saturatedFat'] != null ? int.parse(json['saturatedFat']!) : null,
      cholesterol: json['cholesterol'] != null ? int.parse(json['cholesterol']!) : null,
      sodium: json['sodium'] != null ? int.parse(json['sodium']!) : null,
      fiber: json['fiber'] != null ? int.parse(json['fiber']!) : null,
      createdAt: json['createdAt']!,
      updatedAt: json['updatedAt']!,
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
  final int? carbs;
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
      'carbs': carbs,
      'saturatedFat': saturatedFat,
      'cholesterol': cholesterol,
      'sodium': sodium,
      'fiber': fiber,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
