import 'package:rlv2_flutter/features/organization/models/create_organization_user_role_model.dart';

class OrganizationUserRole extends CreateOrganizationUserRole {
  OrganizationUserRole({
    required this.createdAt,
    required this.updatedAt,
    required super.organizationUserId,
    required super.roleId,
  });

  factory OrganizationUserRole.fromJson(Map<String, dynamic> json) {
    return OrganizationUserRole(
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      organizationUserId: json['organization_user_id'] as String,
      roleId: json['role_id'] as String,
    );
  }

  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  Map<String, dynamic> toJson() {
    return {
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'organization_user_id': organizationUserId,
      'role_id': roleId,
    };
  }

  @override
  String toString() {
    return 'OrganizationUserRole(createdAt: $createdAt, '
        'updatedAt: $updatedAt, '
        'organizationUserId: $organizationUserId, '
        'roleId: $roleId)';
  }
}
