// lib/features/auth/models/auth_state_model.dart

import 'package:rlv2_flutter/features/user/models/user_model.dart';

class AuthStateModel {
  AuthStateModel({
    required this.isAuthenticated,
    this.user,
    this.error,
    this.isLoading = false,
  });
  factory AuthStateModel.initial() => AuthStateModel(isAuthenticated: false);

  factory AuthStateModel.loading() => AuthStateModel(
        isAuthenticated: false,
        isLoading: true,
      );

  factory AuthStateModel.authenticated(User user) => AuthStateModel(
        isAuthenticated: true,
        user: user,
      );

  factory AuthStateModel.unauthenticated([String? error]) => AuthStateModel(
        isAuthenticated: false,
        error: error,
      );

  factory AuthStateModel.error(String error) => AuthStateModel(
        isAuthenticated: false,
        error: error,
      );
  final bool isAuthenticated;
  final User? user;
  final String? error;
  final bool isLoading;
}
