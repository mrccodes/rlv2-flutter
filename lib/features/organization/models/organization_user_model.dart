import 'package:rlv2_flutter/features/organization/models/create_organization_user_model.dart';

class OrganizationUser extends CreateOrganizationUser{
  OrganizationUser({
    required this.id,
    required this.isOwner,
    required this.username,
    required this.organizationName,
    required this.createdAt,
    required super.userId,
    required super.organizationId,
  });

  factory OrganizationUser.fromJson(Map<String, dynamic> json) {
    return OrganizationUser(
      id: json['id'] as String,
      organizationId: json['organizationId'] as String,
      userId: json['userId'] as String,
      isOwner: json['isOwner'] as String,
      username: json['username'] as String,
      organizationName: json['organizationName'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  final String id;
  final String isOwner;
  final String username;
  final String organizationName;
  final String createdAt;

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data['id'] = id;
    data['isOwner'] = isOwner;
    data['username'] = username;
    data['organizationName'] = organizationName;
    data['createdAt'] = createdAt;
    return data;
  }

  @override
  String toString() {
    return 'OrganizationUser{id: $id, '
        'isOwner: $isOwner, '
        'username: $username, '
        'organizationId: $organizationId, '
        'userId: $userId, '
        'organizationName: $organizationName, '
        'createdAt: $createdAt}';
  }
}
