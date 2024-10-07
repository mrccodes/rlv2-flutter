import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_serice_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_service.dart';

class UserState {
  UserState({
    this.data,
    this.isLoading = false,
    this.error,
  });

  factory UserState.initial() {
    return UserState();
  }

  final User? data;
  final bool isLoading;
  final String? error;

  UserState copyWith({
    User? data,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      data: data ?? this.data,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserState>(
  (ref) {
    return UserNotifier(ref.watch(userServiceProvider));
  },
);

class UserNotifier extends StateNotifier<UserState> {
  UserNotifier(
    this._userService,
  ) : super(UserState());
  final UserService _userService;

  bool get isAuthenticated {
    return state.data != null && state.data!.id.isNotEmpty;
  }

  bool get isLoading {
    return state.isLoading == true;
  }

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  set user(User? newUser) {
    state = state.copyWith(data: newUser);
  }

  User? get user {
    return state.data;
  }

  void clearUser() {
    // ignore: avoid_redundant_argument_values
    state = state.copyWith(data: null);
  }

  void updateUserLocal(User user) {
    state = state.copyWith(data: user);
  }

  Future<void> fetchUser(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _userService.fetchUser(userId);
      state = state.copyWith(data: user);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateUsername({
    required String userId,
    required String username,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _userService.updateUsername(
        userId: userId,
        username: username,
      );
      state = state.copyWith(data: response);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updateEmail({
    required String userId,
    required String email,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _userService.updateEmail(
        userId: userId,
        email: email,
      );
      state = state.copyWith(data: response);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> updatePassword({
    required String userId,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await _userService.updatePassword(
        userId: userId,
        password: password,
      );
      state = state.copyWith(data: response);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
