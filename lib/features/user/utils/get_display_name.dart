import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/auth/providers/auth_provider.dart';
import 'package:rlv2_flutter/features/user/providers/user_information_provider.dart';

String getDisplayName(WidgetRef ref) {
  final username = ref.read(authProvider).user?.username;
  final formattedUsername = username != null ? '@$username' : null;
  final firstName = ref.read(userInformationProvider).data?.firstName;
  return firstName ?? formattedUsername ?? '';
}
