// lib/features/dashboard/dashboard_view_model.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/auth/models/user_information_model.dart';

/// Define the state of the dashboard.
class DashboardState {
  DashboardState({
    this.isLoading = false,
    this.errorMessage = '',
  });

  final bool isLoading;
  final String errorMessage;

  DashboardState copyWith({
    String? firstName,
    bool? isLoading,
    String? errorMessage,
    UserInformation? userInformation,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// The ViewModel extends StateNotifier to manage the DashboardState.
class DashboardViewModel extends StateNotifier<DashboardState> {
  DashboardViewModel(this.ref) : super(DashboardState());
  final Ref ref;
}
