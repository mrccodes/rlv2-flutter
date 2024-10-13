import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/organization/models/create_organization_model.dart';
import 'package:rlv2_flutter/features/organization/models/organization_model.dart';
import 'package:rlv2_flutter/features/organization/providers/organization_service_provider.dart';
import 'package:rlv2_flutter/features/organization/services/organization_service.dart';
import 'package:rlv2_flutter/features/organization/utils/personal_recipes_dummy_org.dart';
import 'package:rlv2_flutter/features/recipe/providers/category_provider.dart';

class OrganizationState {
  OrganizationState({
    this.isLoading = false,
    Organization? selectedOrganization,
    this.error,
  }) : selectedOrganization =
            selectedOrganization ?? PersonalRecipesDummyOrg.instance;

  final bool isLoading;
  final String? error;
  final Organization selectedOrganization;

  OrganizationState copyWith({
    bool? isLoading,
    String? error,
    Organization? selectedOrganization,
  }) {
    return OrganizationState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      selectedOrganization: selectedOrganization ?? this.selectedOrganization,
    );
  }
}

final organizationProvider =
    StateNotifierProvider<OrganizationNotifier, OrganizationState>((ref) {
  final organizationService = ref.watch(organizationServiceProvider);
  return OrganizationNotifier(
      organizationService, ref.watch(categoryProvider.notifier),
      );
});

class OrganizationNotifier extends StateNotifier<OrganizationState> {
  OrganizationNotifier(
    this._organizationService,
    this._categoryNotifier,
  ) : super(OrganizationState());
  final OrganizationService _organizationService;
  final CategoryNotifier _categoryNotifier;

  bool get isLoading {
    return state.isLoading == true;
  }

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<Organization> fetchOrganization(String organizationId) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _organizationService.fetchOrganizationById(
        organizationId: organizationId,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Organization selectOrganization(Organization organization) {
    state = state.copyWith(selectedOrganization: organization);
    _categoryNotifier.clearSelections();
    return organization;
  }

  void clearSelectedOrganization() {
    state = state.copyWith(
      selectedOrganization: PersonalRecipesDummyOrg.instance,
    );
  }

  Future<List<Organization>> fetchOrganizations() async {
    state = state.copyWith(isLoading: true);
    try {
      return await _organizationService.fetchOrganizations();
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<Organization> createOrganization(CreateOrganization data) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _organizationService.createOrganization(data: data);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<Organization> updateOrganization(
    String organizationId,
    Organization data,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _organizationService.updateOrganization(
        organizationId: organizationId,
        data: data,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteOrganization(String organizationId) async {
    state = state.copyWith(isLoading: true);
    try {
      await _organizationService.deleteOrganization(
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
