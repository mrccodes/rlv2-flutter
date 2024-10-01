// lib/features/dashboard/dashboard_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Define the state of the dashboard.
class DashboardState {
  DashboardState({
    this.firstName = '',
    this.isLoading = false,
    this.errorMessage = '',
  });

  final String firstName;
  final bool isLoading;
  final String errorMessage;

  DashboardState copyWith({
    String? firstName,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      firstName: firstName ?? this.firstName,
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
      await Future.delayed(const Duration(seconds: 2));
      // Update state with new data.
      state = state.copyWith(
        firstName:'Matt',
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
