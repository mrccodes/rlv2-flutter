import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/organization/models/create_organization_model.dart';
import 'package:rlv2_flutter/features/organization/models/organization_model.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class OrganizationRepository {
  OrganizationRepository({
    required this.apiService,
  });

  final ApiService apiService;

  Future<List<Organization>> fetchOrganizations() async {
    const endpoint = '/organizations';

    try {
      final response = await apiService.getRequest<List<Organization>>(
        endpoint,
        (data) => (data as List)
            .map(
              (e) => Organization.fromJson(e as Map<String, dynamic>),
            )
            .toList(),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch organizations');
      rethrow;
    }
  }

  Future<Organization> fetchOrganizationById({
    required String organizationId,
  }) async {
    final endpoint = '/organizations/$organizationId';

    try {
      final response = await apiService.getRequest<Organization>(
        endpoint,
        Organization.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch organization');
      rethrow;
    }
  }

  Future<Organization> createOrganization({
    required CreateOrganization data,
  }) async {
    try {
      final response = await apiService.postRequest(
        '/organizations',
        data.toJson(),
        Organization.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to create organization');
      rethrow;
    }
  }

  Future<Organization> updateOrganization({
    required String organizationId,
    required Organization data,
  }) async {
    try {
      final response = await apiService.patchRequest(
        '/organizations/$organizationId',
        data.toJson(),
        Organization.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update organization');
      rethrow;
    }
  }

  Future<Organization> deleteOrganization({
    required String organizationId,
  }) async {
    try {
      final response = await apiService.deleteRequest(
        '/organizations/$organizationId',
        Organization.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to delete organization');
      rethrow;
    }
  }

  Future<Organization> patchOrganization({
    required String organizationId,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await apiService.patchRequest(
        '/organizations/$organizationId',
        data,
        Organization.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to patch organization');
      rethrow;
    }
  }
}
