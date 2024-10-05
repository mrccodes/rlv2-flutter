import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/repositories/auth_repository.dart';
import 'package:rlv2_flutter/features/auth/view_models/auth_view_model.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';

class MockAuthNotifier extends StateNotifier<AuthState>
    implements AuthNotifier {
  MockAuthNotifier({User? user})
      : super(
          AuthState(
            user: user, // Optional user, can be null
          ),
        );

  @override
  AuthRepository get authRepository => throw UnimplementedError();

  @override
  Future<void> login(String email, String password) async {
    state = AuthState(
      user: User(
        id: 'userId',
        username: 'username',
        email: email,
        password: password,
        stripeCustomerId: 'stripeId',
        createdAt: '11111',
        updatedAt: '11111',
      ),
    );
  }

  @override
  Future<void> logout() async {
    state = AuthState();
  }

  @override
  FlutterSecureStorage get storage => throw UnimplementedError();
}
