import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/user_information_model.dart';

final dashboardProvider =
    StateNotifierProvider<DashboardNotifier, DashboardState>(
  DashboardNotifier.new,
);

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

class DashboardNotifier extends StateNotifier<DashboardState> {
  DashboardNotifier(this.ref) : super(DashboardState());
  final Ref ref;
}
