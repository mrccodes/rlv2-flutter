import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/create_user_information_model.dart';
import 'package:rlv2_flutter/features/user/models/user_information_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_information_service_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_information_service.dart';

class UserInformationState {
  UserInformationState({
    this.data,
    this.isLoading = false,
    this.error,
  });

  factory UserInformationState.initial() {
    return UserInformationState();
  }

  final UserInformation? data;
  final bool isLoading;
  final String? error;

  @override
  String toString() {
    return 'UserInformationState('
        'data: $data, '
        'isLoading: $isLoading, '
        'error: $error)';
  }

  UserInformationState copyWith({
    UserInformation? data,
    bool? isLoading,
    String? error,
  }) {
    return UserInformationState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final userInformationProvider =
    StateNotifierProvider<UserInformationNotifier, UserInformationState>((ref) {
  final service = ref.watch(userInformationServiceProvider);
  return UserInformationNotifier(service: service);
});

class UserInformationNotifier extends StateNotifier<UserInformationState> {
  UserInformationNotifier({
    required this.service,
  }) : super(UserInformationState.initial());

  final UserInformationService service;

  bool get isLoading => state.isLoading == true;
  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  UserInformation? get loggedInUserInformation => state.data;

  void updateUserInformationLocal(UserInformation userInformation) {
    state = state.copyWith(data: userInformation);
  }

  void clearUserInformation() {
    state = UserInformationState.initial();
  }

  Future<void> loadUserInformation(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      final userInformation = await service.getUserInformation(userId);
      state = state.copyWith(data: userInformation);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<UserInformation> createUserInformation(
    CreateUserInformation data,
  ) async {
    state = state.copyWith(isLoading: true);
    try {
      final userInformation = await service.createUserInformation(data);
      state = state.copyWith(data: userInformation);
      return userInformation;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
