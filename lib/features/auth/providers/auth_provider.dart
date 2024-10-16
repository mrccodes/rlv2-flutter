import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rlv2_flutter/core/models/api_exception_model.dart';
import 'package:rlv2_flutter/features/auth/models/register_model.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_service_provider.dart';
import 'package:rlv2_flutter/features/auth/services/auth_service.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/utils/app_logger.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  const storage = FlutterSecureStorage();
  return AuthNotifier(
    authService: authService,
    storage: storage,
  );
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
  AuthNotifier({
    required this.authService,
    required this.storage,
  }) : super(AuthState());

  final AuthService authService;
  final FlutterSecureStorage storage;

  User? get loggedInUser => state.user;

  Future<void> login(String email, String password) async {
    try {
      final existingId = state.user?.id;
      AppLogger.info('checking for existing id: $existingId');
      state = AuthState(isLoading: true);
      final user = await authService.login(email, password);
      final userId = user.id;
      AppLogger.info('updating AuthState User: $userId');

      state = AuthState(user: user);
      final newStateId = state.user!.id;
      AppLogger.info('writing user_id to storage: $newStateId');
    } on ApiException catch (err) {
      state = AuthState(error: err.errors.join('\n'));
    } on Exception catch (err, stackTrace) {
      state = AuthState(error: 'Unable to login. Please try again.');
      AppLogger.error('Error logging in', err, stackTrace);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }

  Future<void> logout() async {
    state = AuthState();
    if (loggedInUser == null) {
      return;
    }
    await authService.logout(loggedInUser!);
  }

  Future<void> register(Register data) async {
    try {
      state = AuthState(isLoading: true);
      final userSessionContext = await authService.register(data);
      authService.loadUser(userSessionContext);
      state = AuthState(user: userSessionContext.user);
    } catch (e) {
      state = AuthState(error: e.toString());
    }
  }
}
