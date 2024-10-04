import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/services/auth_service.dart';
import 'package:rlv2_flutter/features/auth/view_models/auth_view_model.dart';

class MockAuthNotifier extends StateNotifier<AuthState>
    implements AuthNotifier {
  MockAuthNotifier() : super(AuthState().initial());

  @override
  AuthService get authService => throw UnimplementedError();

  @override
  Future<void> login(String email, String password) {
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  FlutterSecureStorage get storage => throw UnimplementedError();
}
