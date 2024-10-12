class Role {
  Role({
    required this.id,
    required this.description,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as String,
      description: json['description'] as String,
    );
  }

  final String id;
  final String description;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'description': description,
    };
  }

  @override
  String toString() {
    return 'Role{id: $id, description: $description}';
  }
}
