import 'package:rlv2_flutter/features/organization/models/create_organization_model.dart';

class Organization extends CreateOrganization {
  Organization({
    required this.id,
    required super.owner,
    required super.name,
    required this.createdAt,
    required this.updatedAt,
    super.description,
    super.image,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id']! as String,
      owner: json['owner']! as String,
      name: json['name']! as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      description: json['description'] as String?,
      image: json['image'] as String?,
    );
  }

  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['id'] = id;
    data['createdAt'] = createdAt.toIso8601String();
    data['updatedAt'] = updatedAt.toIso8601String();
    return data;
  }

  @override
  String toString() {
    return 'Organization{id: $id, '
        'owner: $owner, '
        'name: $name, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'description: $description, '
        'image: $image}';
  }
}
