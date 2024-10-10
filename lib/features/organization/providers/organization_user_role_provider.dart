import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/models/organization_user_role_model.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_user_role_service_provider.dart';
import 'package:rlv2_flutter/features/organization/services/organization_user_role_service.dart';
import 'package:rlv2_flutter/utils/constants.dart';

class OrganizationUserRoleState {
  OrganizationUserRoleState({
    this.isLoading = false,
    this.error,
  });

  final bool isLoading;
  final String? error;

  OrganizationUserRoleState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return OrganizationUserRoleState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'OrganizationUserRoleState('
        'isLoading: $isLoading, '
        'error: $error)';
  }
}

final organizationUserRoleProvider = StateNotifierProvider<
    OrganizationUserRoleNotifier, OrganizationUserRoleState>((ref) {
  final organizationUserRoleService =
      ref.watch(organizationUserRoleServiceProvider);
  return OrganizationUserRoleNotifier(organizationUserRoleService);
});

class OrganizationUserRoleNotifier
    extends StateNotifier<OrganizationUserRoleState> {
  OrganizationUserRoleNotifier(this._organizationUserRoleService)
      : super(OrganizationUserRoleState());
  final OrganizationUserRoleService _organizationUserRoleService;

  bool get isLoading {
    return state.isLoading == true;
  }

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<List<OrganizationUserRole>> fetchOrganizationUserRoles({
    required String organizationId,
    required String organizationUserId,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _organizationUserRoleService
          .fetchOrganizationUserRolesByUserId(
        organizationId: organizationId,
        organizationUserId: organizationUserId,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<OrganizationUserRole> fetchOrganizationUserRole({
    required String organizationId,
    required String organizationUserId,
    required String organizationUserRoleId,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _organizationUserRoleService.fetchOrganizationUserRoleById(
        organizationId: organizationId,
        organizationUserId: organizationUserId,
        organizationUserRoleId: organizationUserRoleId,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<List<OrganizationUserRole>> updateOrganizationUserRole({
    required String organizationId,
    required String organizationUserId,
    required OrganizationUserRoles roleId,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _organizationUserRoleService.updateOrganizationUserRole(
        organizationId: organizationId,
        organizationUserId: organizationUserId,
        roleId: roleId,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
