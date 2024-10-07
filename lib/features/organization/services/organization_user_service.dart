import 'package:rlv2_flutter/features/organization/models/organization_user_model.dart';
import 'package:rlv2_flutter/features/organization/repositories/organization_user_repository.dart';

class OrganizationUserService {
  OrganizationUserService({
    required this.organizationUserRepository,
  });

  final OrganizationUserRepository organizationUserRepository;

  Future<List<OrganizationUser>> fetchOrganizationUsers({
    required String organizationId,
  }) async {
    try {
      final response = await organizationUserRepository.fetchOrganizationUsers(
        organizationId: organizationId,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch organization users: $e');
    }
  }

  Future<OrganizationUser> fetchOrganizationUserById({
    required String organizationId,
    required String organizationUserId,
  }) async {
    try {
      final response =
          await organizationUserRepository.fetchOrganizationUserById(
        organizationId: organizationId,
        organizationUserId: organizationUserId,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch organization user: $e');
    }
  }

  Future<List<OrganizationUser>> fetchOrganizationUsersByUserId({
    required String userId,
  }) async {
    try {
      final response =
          await organizationUserRepository.fetchOrganizationUsersByUserId(
        userId: userId,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to fetch organization users by user id: $e');
    }
  }

  Future<OrganizationUser> createOrganizationUser({
    required String organizationId,
    required OrganizationUser organizationUser,
  }) async {
    try {
      final response = await organizationUserRepository.createOrganizationUser(
        organizationId: organizationId,
        organizationUser: organizationUser,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create organization user: $e');
    }
  }

  Future<OrganizationUser> updateOrganizationUser({
    required String organizationId,
    required String organizationUserId,
    required OrganizationUser organizationUser,
  }) async {
    try {
      final response = await organizationUserRepository.updateOrganizationUser(
        organizationId: organizationId,
        organizationUserId: organizationUserId,
        organizationUser: organizationUser,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to update organization user: $e');
    }
  }

  Future<void> deleteOrganizationUser({
    required String organizationId,
    required String organizationUserId,
  }) async {
    try {
      await organizationUserRepository.deleteOrganizationUser(
        organizationId: organizationId,
        organizationUserId: organizationUserId,
      );
    } catch (e) {
      throw Exception('Failed to delete organization user: $e');
    }
  }
}
