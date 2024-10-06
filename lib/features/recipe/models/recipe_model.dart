class Recipe {
  Recipe({
    required this.id,
    required this.name,
    required this.author,
    this.organizationId,
    this.createdAt,
    this.updatedAt,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      name: json['name'] as String,
      author: json['author'] as String,
      organizationId: json['organizationId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
  final String id;
  final String name;
  final String author;
  final String? organizationId;
  final String? createdAt;
  final String? updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'organizationId': organizationId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
