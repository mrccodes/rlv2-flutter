class Recipe {
  Recipe({
    required this.id,
    required this.name,
    required this.author,
    this.organizationId,
    this.createdAt,
    this.updatedAt,
  });

  factory Recipe.fromJson(Map<String, String> json) {
    return Recipe(
      id: json['id']!,
      name: json['name']!,
      author: json['author']!,
      organizationId: json['organizationId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
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
