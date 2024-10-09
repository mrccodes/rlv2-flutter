

import 'package:rlv2_flutter/utils/constants.dart';

Map<OrganizationUserRoles, List<OrganizationUserRoles>> roleHierarchy = {
  OrganizationUserRoles.member: [],
  OrganizationUserRoles.viewer: [OrganizationUserRoles.member],
  OrganizationUserRoles.creator: [OrganizationUserRoles.viewer],
  OrganizationUserRoles.editor: [OrganizationUserRoles.creator],
  OrganizationUserRoles.admin: [OrganizationUserRoles.editor],
  OrganizationUserRoles.owner: [OrganizationUserRoles.admin],
};

Future<List<OrganizationUserRoles>> getOrgUserSubRoleIds(
  OrganizationUserRoles role,
  ) async {
  final subRoles = <OrganizationUserRoles>[];
  void addSubRoles(OrganizationUserRoles currentRole) {
    subRoles.add(currentRole);
    if (roleHierarchy.containsKey(currentRole)) {
      for (final subRole in roleHierarchy[currentRole]!) {
        addSubRoles(subRole);
      }
    }
  }

  addSubRoles(role);
  return subRoles;
}
