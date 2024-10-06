// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:rlv2_flutter/features/auth/models/user_session_context_model.dart';
// import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
// import 'package:rlv2_flutter/features/auth/providers/user_session_context_service_provider.dart';
// import 'package:rlv2_flutter/features/auth/services/user_session_context_service.dart';
// import 'package:rlv2_flutter/features/user/providers/user_settings_provider.dart';
// import 'package:rlv2_flutter/utils/app_logger.dart';

// // UserSessionNotifier provider
// final userSessionContextProvider =
//     StateNotifierProvider<UserSessionContextNotifier, UserSessionContextState>(
//         (ref) {
//   final userSessionService = ref.watch(userSessionContextServiceProvider);
//   return UserSessionContextNotifier(
//     service: userSessionService,
//     ref: ref,
//   );
// });

// // Listen to AuthState and trigger loadUserSession on userId change
// final userSessionListenerProvider = Provider<void>((ref) {
//   ref..listen<AuthState>(authProvider, (previous, next) {
//     final previousUserId = previous?.user?.id;
//     final nextUserId = next.user?.id;

//     if (previousUserId != nextUserId && nextUserId != null) {
//       ref.read(userSessionContextProvider.notifier).loadUserSession(nextUserId);
//     }
//   })

//   ..listen<UserSettingsState>(userSettingsProvider, (previous, next) {
//     final previousUserId = previous?.userSettings;
//     final nextUserId = next.userSettings;

//     if (previousUserId != nextUserId && nextUserId != null) {
//       ref.read(userSessionContextProvider.notifier).loadUserSession(nextUserId);
//     }
//   });
// });

// // UserSessionContextState holds the state of UserSessionContext
// class UserSessionContextState {
//   UserSessionContextState({
//     this.userSessionContext,
//     this.isLoading = false,
//     this.error,
//   });

//   final UserSessionContext? userSessionContext;
//   final bool isLoading;
//   final String? error;

//   @override
//   String toString() {
//     return 'UserSessionContextState(userSessionContext: '
//         '$userSessionContext, isLoading: $isLoading, error: $error)';
//   }

//   UserSessionContextState copyWith({
//     UserSessionContext? userSessionContext,
//     bool? isLoading,
//     String? error,
//   }) {
//     return UserSessionContextState(
//       userSessionContext: userSessionContext ?? this.userSessionContext,
//       isLoading: isLoading ?? this.isLoading,
//       error: error ?? this.error,
//     );

//   }
// }

// class UserSessionContextNotifier
//     extends StateNotifier<UserSessionContextState> {
//   UserSessionContextNotifier({
//     required this.service,
//     required this.ref,
//   }) : super(UserSessionContextState());

//   final UserSessionContextService service;
//   final Ref ref;

//   Future<void> loadUserSession(String userId) async {
//     try {
//       AppLogger.info('Loading user session for user: $userId');
//       state = UserSessionContextState(isLoading: true);

//       final userSessionContext = await service.fetchUserSessionContext(userId);

//       await ref
//           .read(userSettingsProvider.notifier)
//           .updateUserSettings(userId, userSessionContext.userSettings);

//       state = UserSessionContextState(userSessionContext: userSessionContext);
//       AppLogger.info(
//         'State updated with user session data $userSessionContext',
//       );
//     } catch (e, stackTrace) {
//       AppLogger.error('Error loading user session: $e');
//       AppLogger.error('Stack trace: $stackTrace');
//       state = UserSessionContextState(error: e.toString());
//     }
//   }

//   Future<void> clearUserSession() async {
//     state = UserSessionContextState();
//   }

//   Future<void> updateUserSession(UserSessionContext userSessionContext) async {
//     state = UserSessionContextState(userSessionContext: userSessionContext);
//   }
// }
