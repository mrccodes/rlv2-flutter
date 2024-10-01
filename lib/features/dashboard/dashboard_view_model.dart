// lib/features/dashboard/dashboard_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Define the state of the dashboard.
class DashboardState {
  DashboardState({
    this.notificationsCount = 0,
    this.isLoading = false,
    this.errorMessage = '',
  });

  final int notificationsCount;
  final bool isLoading;
  final String errorMessage;

  DashboardState copyWith({
    int? notificationsCount,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      notificationsCount: notificationsCount ?? this.notificationsCount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// The ViewModel extends StateNotifier to manage the DashboardState.
class DashboardViewModel extends StateNotifier<DashboardState> {
  DashboardViewModel() : super(DashboardState());

  /// Simulate data loading.
  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    try {
      // Simulate a network call.
      await Future.delayed(Duration(seconds: 2));
      // Update state with new data.
      state = state.copyWith(
        notificationsCount: 5,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load dashboard data.',
      );
    }
  }
}
