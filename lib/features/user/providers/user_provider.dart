import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/create_user_model.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_serice_provider.dart';
import 'package:rlv2_flutter/features/user/services/user_service.dart';

class UserState {
  UserState({
    this.isLoading = false,
    this.error,
  });

  factory UserState.initial() {
    return UserState();
  }

  final bool isLoading;
  final String? error;

  UserState copyWith({
    User? data,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
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

  bool get isLoading {
    return state.isLoading == true;
  }

  set isLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  Future<User> fetchUser(String userId) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _userService.fetchUser(userId);
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<User> createUser({
    required String email,
    required String password,
    required String username,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _userService.createUser(
        data: CreateUser(
          email: email,
          password: password,
          username: username,
        ),
      );
      return user;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<User> updateUsername({
    required String userId,
    required String username,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _userService.updateUsername(
        userId: userId,
        username: username,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<User> updateEmail({
    required String userId,
    required String email,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _userService.updateEmail(
        userId: userId,
        email: email,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<User> updatePassword({
    required String userId,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      return await _userService.updatePassword(
        userId: userId,
        password: password,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
