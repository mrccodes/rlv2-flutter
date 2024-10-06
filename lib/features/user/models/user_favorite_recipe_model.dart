class UserFavoriteRecipe {
  UserFavoriteRecipe({
    required this.id,
    required this.recipeVersionId,
    required this.userId,
    required this.createdAt,
    required this.recipeId,
    required this.recipeName,
    required this.recipeAuthor,
    required this.username,
    this.recipeVersionDescription,
  });

  factory UserFavoriteRecipe.fromJson(Map<String, dynamic> json) {
    return UserFavoriteRecipe(
      id: json['id'] as String,
      recipeVersionId: json['recipeVersionId'] as String,
      userId: json['userId'] as String,
      recipeId: json['recipeId'] as String,
      createdAt: json['createdAt'] as String,
      recipeName: json['recipeName'] as String,
      recipeAuthor: json['recipeAuthor'] as String,
      recipeVersionDescription: json['recipeVersionDescription'] as String?,
      username: json['username'] as String,
    );
  }

  final String id;
  final String recipeVersionId;
  final String userId;
  final String recipeId;
  final String createdAt;
  final String recipeName;
  final String recipeAuthor;
  final String username;
  final String? recipeVersionDescription;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'recipeVersionId': recipeVersionId,
      'userId': userId,
      'recipeId': recipeId,
      'createdAt': createdAt,
      'recipeName': recipeName,
      'recipeAuthor': recipeAuthor,
      'recipeVersionDescription': recipeVersionDescription,
      'username': username,
    };
  }
}
