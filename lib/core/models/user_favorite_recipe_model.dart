class UserFavoriteRecipe {
  UserFavoriteRecipe({
    required this.id,
    required this.recipeVersionId,
    required this.userId,
    required this.createdAt,
    required this.recipeId,
    required this.recipeName,
    required this.recipeAuthor,
    required this.recipeVersionDescription,
    required this.username,
  });

  factory UserFavoriteRecipe.fromJson(Map<String, String> json) {
    return UserFavoriteRecipe(
      id: json['id']!,
      recipeVersionId: json['recipeVersionId']!,
      userId: json['userId']!,
      recipeId: json['recipeId']!,
      createdAt: json['createdAt']!,
      recipeName: json['recipeName']!,
      recipeAuthor: json['recipeAuthor']!,
      recipeVersionDescription: json['recipeVersionDescription']!,
      username: json['username']!,
    );
  }
  final String id;
  final String recipeVersionId;
  final String userId;
  final String recipeId;
  final String createdAt;
  final String recipeName;
  final String recipeAuthor;
  final String recipeVersionDescription;
  final String username;

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
