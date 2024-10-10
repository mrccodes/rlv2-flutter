import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/models/create_organization_user_model.dart';
import 'package:rlv2_flutter/features/organization/models/organization_user_model.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_user_service_provider.dart';
import 'package:rlv2_flutter/features/organization/services/organization_user_service.dart';

class OrganizationUserState {
  OrganizationUserState({
    this.isLoading = false,
    this.error,
  });

  factory OrganizationUserState.initial() {
    return OrganizationUserState();
  }

  factory OrganizationUserState.fromJson(Map<String, dynamic> json) {
    return OrganizationUserState(
      isLoading: json['isLoading']! as bool,
      error: json['error']! as String,
    );
  }

  final bool isLoading;
  final String? error;

  OrganizationUserState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return OrganizationUserState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final organizationUserProvider =
    StateNotifierProvider<OrganizationUserNotifier, OrganizationUserState>(
  (ref) {
    return OrganizationUserNotifier(ref.watch(organizationUserServiceProvider));
  },
);

class OrganizationUserNotifier extends StateNotifier<OrganizationUserState> {
  OrganizationUserNotifier(
    this._organizationUserService,
  ) : super(OrganizationUserState());

  final OrganizationUserService _organizationUserService;

  bool get isLoading {
    return state.isLoading == true;
  }

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<OrganizationUser> fetchOrganizationUser(
    String organizationId,
    String organizationUserId,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _organizationUserService.fetchOrganizationUserById(
        organizationUserId: organizationUserId,
        organizationId: organizationId,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<OrganizationUser> createOrganizationUser({
    required CreateOrganizationUser organizationUser,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _organizationUserService.createOrganizationUser(
        organizationId: organizationUser.organizationId,
        organizationUser: organizationUser,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteOrganizationUser(
    String organizationId,
    String organizationUserId,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      await _organizationUserService.deleteOrganizationUser(
        organizationUserId: organizationUserId,
        organizationId: organizationId,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
