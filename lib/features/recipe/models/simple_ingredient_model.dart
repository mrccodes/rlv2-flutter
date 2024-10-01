class SimpleIngredient {
  SimpleIngredient({
    required this.id,
    required this.name,
    required this.brand,
    required this.origin,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SimpleIngredient.fromJson(Map<String, String> json) {
    return SimpleIngredient(
      id: json['id']!,
      name: json['name']!,
      brand: json['brand']!,
      origin: json['origin']!,
      createdAt: json['createdAt']!,
      updatedAt: json['updatedAt']!,
    );
  }
  final String id;
  final String name;
  final String brand;
  final String origin;
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
