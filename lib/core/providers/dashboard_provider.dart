import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/dashboard/dashboard_view_model.dart';

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, DashboardState>(
  (ref) => DashboardViewModel(),
);
