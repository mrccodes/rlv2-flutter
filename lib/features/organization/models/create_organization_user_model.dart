class CreateOrganizationUser {
  CreateOrganizationUser({
    required this.organizationId,
    required this.userId,
  });

  factory CreateOrganizationUser.fromJson(Map<String, dynamic> json) {
    return CreateOrganizationUser(
      organizationId: json['organizationId']! as String,
      userId: json['userId']! as String,
    );
  }

  final String organizationId;
  final String userId;

  Map<String, dynamic> toJson() {
    return {
      'organizationId': organizationId,
      'userId': userId,
    };
  }

  @override
  String toString() {
    return 'CreateOrganizationUser{organizationId: $organizationId, '
        'userId: $userId}';
  }
}
