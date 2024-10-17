class CreateSimpleIngredient {
  CreateSimpleIngredient({
    required this.name,
    this.brand,
    this.origin,
  });

  factory CreateSimpleIngredient.fromJson(Map<String, dynamic> json) {
    return CreateSimpleIngredient(
      name: json['name']! as String,
      brand: json['brand'] as String?,
      origin: json['origin'] as String?,
    );
  }

  final String name;
  final String? brand;
  final String? origin;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'brand': brand,
      'origin': origin,
    };
  }
}
