import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/models/organization_user_model.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_user_service_provider.dart';
import 'package:rlv2_flutter/features/organization/services/organization_user_service.dart';
import 'package:rlv2_flutter/utils/constants.dart';

class UserOrganizationsState {
  UserOrganizationsState({
    this.data = const [],
    this.isLoading = false,
    this.error,
  });

  final List<OrganizationUser> data;
  final bool isLoading;
  final String? error;

  UserOrganizationsState copyWith({
    List<OrganizationUser>? data,
    bool? isLoading,
    String? error,
  }) {
    return UserOrganizationsState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'UserOrganizationsState('
        'data: $data, '
        'isLoading: $isLoading, '
        'error: $error)';
  }
}

final userOrganizationsProvider =
    StateNotifierProvider<UserOrganizationsNotifier, UserOrganizationsState>(
        (ref) {
  final organizationUserService = ref.watch(organizationUserServiceProvider);
  return UserOrganizationsNotifier(organizationUserService);
});

class UserOrganizationsNotifier extends StateNotifier<UserOrganizationsState> {
  UserOrganizationsNotifier(this._organizationUserService)
      : super(UserOrganizationsState());

  final OrganizationUserService _organizationUserService;

  bool get isLoading {
    return state.isLoading == true;
  }

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<void> fetchUserOrganizations(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      final organizations =
          await _organizationUserService.fetchOrganizationUsersByUserId(
        userId: userId,
      );

      // ensure user only sees organizations they have view access to
      final filteredOrganizations = organizations
          .where((org) => org.roles.contains(OrganizationUserRoles.viewer.name))
          .toList();

      state = state.copyWith(data: filteredOrganizations);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void updateUserOrganzationsLocal(
    List<OrganizationUser> organizationUsers,
  ) {
    state = state.copyWith(isLoading: true, data: organizationUsers);
  }

  void clearUserOrganizations() {
    state = UserOrganizationsState();
  }
}
