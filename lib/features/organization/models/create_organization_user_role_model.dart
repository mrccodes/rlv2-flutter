class CreateOrganizationUserRole {
  CreateOrganizationUserRole({
    required this.organizationUserId,
    required this.roleId,
  });

  factory CreateOrganizationUserRole.fromJson(Map<String, dynamic> json) =>
      CreateOrganizationUserRole(
        organizationUserId: json['organizationUserId']! as String,
        roleId: json['roleId']! as String,
      );

  String organizationUserId;
  String roleId;


  Map<String, dynamic> toJson() => {
        'organizationUserId': organizationUserId,
        'roleId': roleId,
      };

    @override
  String toString() {
    return 'CreateOrganizationUserRole(organizationUserId: $organizationUserId, roleId: $roleId)';
  }

}
