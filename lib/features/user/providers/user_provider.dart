import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';

class UserState {
  UserState({
    required this.user,
    required this.isLoading,
    this.error,
  });

  factory UserState.initial() {
    return UserState(
      user: null,
      isLoading: false,
    );
  }

  final User? user;
  final bool isLoading;
  final String? error;

  UserState copyWith({
    User? user,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

final userProvider = NotifierProvider<UserNotifier, UserState?>(
  UserNotifier.new,
);

class UserNotifier extends Notifier<UserState?> {
  @override
  UserState? build() {
    return UserState.initial();
  }

  set user(User newUser) {
    state = state!.copyWith(user: newUser);
  }

  User get user {
    return state!.user!;
  }

  void clearUser() {
    // ignore: avoid_redundant_argument_values
    state = state!.copyWith(user: null);
  }

  void updateName(String newUsername) {
    if (state != null && state!.user != null) {
      // Update user name deeply and update the state
      final updatedUser = state!.user!.copyWith(username: newUsername);
      state = state!.copyWith(user: updatedUser);
    }
  }

  void updateEmail(String newEmail) {
    if (state != null && state!.user != null) {
      // Update email deeply and update the state
      final updatedUser = state!.user!.copyWith(email: newEmail);
      state = state!.copyWith(user: updatedUser);
    }
  }
}
