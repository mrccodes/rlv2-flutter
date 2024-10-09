import 'package:rlv2_flutter/features/organization/models/organization_user_role_model.dart';
import 'package:rlv2_flutter/features/organization/repositories/organization_user_role_repository.dart';
import 'package:rlv2_flutter/utils/constants.dart';

class OrganizationUserRoleService {
  OrganizationUserRoleService({
    required this.organizationUserRoleRepository,
  });

  final OrganizationUserRoleRepository organizationUserRoleRepository;

  Future<OrganizationUserRole> fetchOrganizationUserRoleById({
    required String organizationId,
    required String organizationUserId,
    required String organizationUserRoleId,
  }) async {
    try {
      return await organizationUserRoleRepository.fetchOrganizationUserRoleById(
        organizationId: organizationId,
        organizationUserId: organizationUserId,
        organizationUserRoleId: organizationUserRoleId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrganizationUserRole>> fetchOrganizationUserRolesByUserId({
    required String organizationId,
    required String organizationUserId,
  }) async {
    try {
      return await organizationUserRoleRepository
        .fetchOrganizationUserRolesByUserId(
        organizationId: organizationId,
        organizationUserId: organizationUserId,
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<OrganizationUserRole>> updateOrganizationUserRole({
    required String organizationId,
    required String organizationUserId,
    required OrganizationUserRoles roleId,
  }) async {
    try {
      return await organizationUserRoleRepository.updateOrganizationUserRole(
        organizationId: organizationId,
        organizationUserId: organizationUserId,
        roleId: roleId,
      );
    } catch (e) {
      rethrow;
    }
  }
}
