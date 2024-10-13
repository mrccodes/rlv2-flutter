class Allergen {
  Allergen({
    required this.id,
    required this.label,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Allergen.fromJson(Map<String, dynamic> json) {
    return Allergen(
      id: json['id'] as String,
      label: json['label'] as String,
      value: json['value'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
  final String id;
  final String label;
  final String value;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'value': value,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
