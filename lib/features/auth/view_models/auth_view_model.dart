import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/features/auth/models/user_model.dart';
import 'package:rlv2_flutter/features/auth/services/auth_service.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

class AuthState {
  AuthState({this.user, this.isLoading = false, this.error});
  final User? user;
  final bool isLoading;
  final String? error;
  bool get isAuthenticated => user != null;
  AuthState Function() initial = AuthState.new; 
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required this.authService, required this.storage})
      : super(AuthState());
  final AuthService authService;
  final FlutterSecureStorage storage;

  Future<void> login(String email, String password) async {
    try {
      final existingId = state.user?.id;
      AppLogger.info('checking for existing id: $existingId');
      state = AuthState(isLoading: true);
      final user = await authService.login(email: email, password: password);
      final userId = user.id;
      AppLogger.info('updating AuthState User: $userId');

      state = AuthState(user: user);
      final newStateId = state.user!.id;
      AppLogger.info('writing user_id to storage: $newStateId');
      // await storage.write(key: 'user_id', value: user.id);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'user_id');
    state = AuthState();
  }
}
