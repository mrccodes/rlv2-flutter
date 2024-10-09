import 'package:rlv2_flutter/features/organization/models/create_organization_model.dart';
import 'package:rlv2_flutter/features/organization/models/organization_model.dart';
import 'package:rlv2_flutter/features/organization/repositories/organization_repository.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class OrganizationService {
  OrganizationService({
    required this.organizationRepository,
  });

  final OrganizationRepository organizationRepository;

  Future<List<Organization>> fetchOrganizations() async {
    try {
      final response = await organizationRepository.fetchOrganizations();
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch organizations');
      rethrow;
    }
  }

  Future<Organization> fetchOrganizationById({
    required String organizationId,
  }) async {
    try {
      final response = await organizationRepository.fetchOrganizationById(
        organizationId: organizationId,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Organization> createOrganization({
    required CreateOrganization data,
  }) async {
    try {
      final response = await organizationRepository.createOrganization(
        data: data,
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
      final response = await organizationRepository.updateOrganization(
        organizationId: organizationId,
        data: data,
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
      return await organizationRepository.deleteOrganization(
        organizationId: organizationId,
      );
    } catch (e) {
      handleError(e, 'Failed to delete organization');
      rethrow;
    }
  }

  Future<Organization> patchOrganization(
    String organizationId,
    Map<String, dynamic> data,
  ) async {
    try {
      return await organizationRepository.patchOrganization(
        organizationId: organizationId,
        data: data,
      );
    } catch (e) {
      handleError(e, 'Failed to patch organization');
      rethrow;
    }
  }
}
