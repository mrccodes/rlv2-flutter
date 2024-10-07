import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/core/models/api_exception_model.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_repository_provider.dart';
import 'package:rlv2_flutter/features/auth/repositories/auth_repository.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  const storage = FlutterSecureStorage();
  return AuthNotifier(authRepository: authRepository, storage: storage);
});

class AuthState {
  AuthState({this.user, this.isLoading = false, this.error});
  final User? user;
  final bool isLoading;
  final String? error;
  bool get isAuthenticated => user != null;
  AuthState Function() initial = AuthState.new;
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({required this.authRepository, required this.storage})
      : super(AuthState());
  final AuthRepository authRepository;
  final FlutterSecureStorage storage;

  Future<void> login(String email, String password) async {
    try {
      final existingId = state.user?.id;
      AppLogger.info('checking for existing id: $existingId');
      state = AuthState(isLoading: true);
      final user = await authRepository.login(email: email, password: password);
      final userId = user.id;
      AppLogger.info('updating AuthState User: $userId');

      state = AuthState(user: user);
      final newStateId = state.user!.id;
      AppLogger.info('writing user_id to storage: $newStateId');
    } on ApiException catch (err) {
        if (err.statusCode == 401) {
          state = AuthState(error: 'Invalid email or password');
        } else if (err.statusCode == 404) {
          state = AuthState(error: 'User does not exist');  
        } else if (err.statusCode == 400) {
          state = AuthState(error: 'Invalid password');
        }
      } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'user_id');
    state = AuthState();
  }
}
