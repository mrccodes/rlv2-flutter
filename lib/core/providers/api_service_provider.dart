import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/core/services/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(); // Pass the necessary config, base URL, or dependencies
});
