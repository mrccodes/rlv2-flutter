class Allergen {
  Allergen({
    required this.id,
    required this.label,
    required this.value,
    required this.versionId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Allergen.fromJson(Map<String, String> json) {
    return Allergen(
      id: json['id']!,
      label: json['label']!,
      value: json['value']!,
      versionId: json['versionId']!,
      createdAt: json['createdAt']!,
      updatedAt: json['updatedAt']!,
    );
  }
  final String id;
  final String label;
  final String value;
  final String versionId;
  final String createdAt;
  final String updatedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'value': value,
      'versionId': versionId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
