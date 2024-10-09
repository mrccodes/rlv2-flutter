import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_provider.dart';

import 'constants.dart';

class MockUserNotifier extends StateNotifier<UserState>
    implements UserNotifier {
  MockUserNotifier({this.isLoading = false})
      : super(
          UserState(
            isLoading: isLoading,
          ),
        );

  @override
  bool isLoading;

  @override
  Future<User> updateEmail({required String userId, required String email}) {
    return Future.value(testUser);
  }

  @override
  Future<User> createUser({
    required String email,
    required String password,
    String? username,
  }) {
    return Future.value(testUser);
  }

  @override
  Future<User> fetchUser(String userId) {
    return Future.value(testUser);
  }

  @override
  Future<User> updatePassword({
    required String userId,
    required String password,
  }) {
    return Future.value(testUser);
  }


  @override
  Future<User> updateUsername({
    required String userId,
    required String username,
  }) {
    return Future.value(testUser);
  }

}
