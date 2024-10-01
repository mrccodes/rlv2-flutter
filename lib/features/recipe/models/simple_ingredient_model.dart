class SimpleIngredient {
  SimpleIngredient({
    required this.id,
    required this.name,
    this.brand,
    this.origin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SimpleIngredient.fromJson(Map<String, dynamic> json) {
    return SimpleIngredient(
      id: json['id']! as String,
      name: json['name']! as String,
      brand: json['brand'] as String?,
      origin: json['origin'] as String?,
      createdAt: json['createdAt']! as String,
      updatedAt: json['updatedAt']! as String,
    );
  }

  final String id;
  final String name;
  final String? brand;
  final String? origin;
  final String createdAt;
  final String updatedAt;


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'origin': origin,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
