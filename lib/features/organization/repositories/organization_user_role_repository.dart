import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/organization/models/organization_user_role_model.dart';
import 'package:rlv2_flutter/utils/constants.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class OrganizationUserRoleRepository {
  OrganizationUserRoleRepository({
    required this.apiService,
  });

  final ApiService apiService;



  Future<OrganizationUserRole> fetchOrganizationUserRoleById({
    required String organizationId,
    required String organizationUserId,
    required String organizationUserRoleId,
  }) async {
    final endpoint = '/organizations/$organizationId/user/$organizationUserId/roles/$organizationUserRoleId';

    try {
      final response = await apiService.getRequest<OrganizationUserRole>(
        endpoint,
        OrganizationUserRole.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch organization user role');
      rethrow;
    }
  }

  Future<List<OrganizationUserRole>> fetchOrganizationUserRolesByUserId({
    required String organizationId,
    required String organizationUserId,
  }) async {
    final endpoint = '/organizations/$organizationId/user/$organizationUserId/roles';

    try {
      final response = await apiService.getRequest<List<OrganizationUserRole>>(
        endpoint,
        (data) => (data as List)
            .map(
              (e) => OrganizationUserRole.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch organization user roles');
      rethrow;
    }
  }

  Future<List<OrganizationUserRole>> updateOrganizationUserRole({
    required String organizationId,
    required String organizationUserId,
    required OrganizationUserRoles roleId,
  }) async {
    final endpoint = '/organizations/$organizationId/user/$organizationUserId/roles/${roleId.name}';

    try {
      final response = await apiService.putRequest<List<OrganizationUserRole>>(
        endpoint,
        {},
        (data) => (data as List)
            .map(
              (e) => OrganizationUserRole.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update organization user roles');
      rethrow;
    } 
  } 


}
