class CreateOrganizationBase {
  CreateOrganizationBase({
    required this.name,
    this.description,
    this.image,
  });

  factory CreateOrganizationBase.fromJson(Map<String, dynamic> json) {
    return CreateOrganizationBase(
      name: json['name']! as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );
  }

  final String name;
  final String? description;
  final String? image;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
    };
  }

  @override
  String toString() {
    return 'CreateOrganization{'
        'name: $name, '
        'description: $description, '
        'image: $image}';
  }
}

class CreateOrganization extends CreateOrganizationBase {
  CreateOrganization({
    required this.owner,
    required super.name,
    super.description,
    super.image,
  });

  factory CreateOrganization.fromJson(Map<String, dynamic> json) {
    return CreateOrganization(
      owner: json['owner']! as String,
      name: json['name']! as String,
      description: json['description'] as String?,
      image: json['image'] as String?,
    );
  }

  final String owner;

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['owner'] = owner;
    return data;
  }

  @override
  String toString() {
    return 'CreateOrganization{owner: $owner, '
        'name: $name, '
        'description: $description, '
        'image: $image}';
  }
}
