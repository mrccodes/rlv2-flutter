import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/organization/models/create_organization_user_model.dart';
import 'package:rlv2_flutter/features/organization/models/organization_user_model.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class OrganizationUserRepository {
  OrganizationUserRepository({
    required this.apiService,
  });

  final ApiService apiService;

  Future<List<OrganizationUser>> fetchOrganizationUsers({
    required String organizationId,
  }) async {
    final endpoint = '/organizations/$organizationId/users';

    try {
      final response = await apiService.getRequest<List<OrganizationUser>>(
        endpoint,
        (data) => (data as List)
            .map(
              (e) => OrganizationUser.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch organization users');
      rethrow;
    }
  }

  Future<OrganizationUser> fetchOrganizationUserById({
    required String organizationId,
    required String organizationUserId,
  }) async {
    final endpoint = '/organizations/$organizationId/users/$organizationUserId';

    try {
      final response = await apiService.getRequest<OrganizationUser>(
        endpoint,
        OrganizationUser.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch organization user');
      rethrow;
    }
  }

  Future<List<OrganizationUser>> fetchOrganizationUsersByUserId({
    required String userId,
  }) async {
    final endpoint = '/users/$userId/organizations/users';

    try {
      final response = await apiService.getRequest<List<OrganizationUser>>(
        endpoint,
        (data) => (data as List)
            .map(
              (e) => OrganizationUser.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch organization users by user id');
      rethrow;
    }
  }

  Future<OrganizationUser> createOrganizationUser({
    required String organizationId,
    required CreateOrganizationUser organizationUser,
  }) async {
    final endpoint = '/organizations/$organizationId/users';

    try {
      final response = await apiService.postRequest<OrganizationUser>(
        endpoint,
        organizationUser.toJson(),
        OrganizationUser.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to create organization user');
      rethrow;
    }
  }

  Future<OrganizationUser> updateOrganizationUser({
    required String organizationId,
    required String organizationUserId,
    required OrganizationUser organizationUser,
  }) async {
    final endpoint = '/organizations/$organizationId/users/$organizationUserId';

    try {
      final response = await apiService.putRequest<OrganizationUser>(
        endpoint,
        organizationUser.toJson(),
        OrganizationUser.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update organization user');
      rethrow;
    }
  }

  Future<OrganizationUser> deleteOrganizationUser({
    required String organizationId,
    required String organizationUserId,
  }) async {
    final endpoint = '/organizations/$organizationId/users/$organizationUserId';

    try {
      final response = await apiService.deleteRequest<OrganizationUser>(
        endpoint,
        OrganizationUser.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to delete organization user');
      rethrow;
    }
  }
}
