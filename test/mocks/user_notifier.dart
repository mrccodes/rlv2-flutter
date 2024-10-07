import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/features/user/providers/user_provider.dart';


class MockUserNotifier extends StateNotifier<UserState>
    implements UserNotifier {
  MockUserNotifier({User? user, this.isLoading = false})
      : super(
          UserState(
            data: user, // Optional user, can be null
            isLoading: isLoading,
          ),
        );

  @override
  bool isLoading;

  @override
  User? user;

  @override
  void clearUser() {
    state = UserState();
  }

  @override
  Future<void> fetchUser(String userId) {
    return Future.value();
  }

  @override
  bool get isAuthenticated => true;

  @override
  Future<void> updateEmail({required String userId, required String email}) {
    return Future.value();
  }

  @override
  Future<void> updatePassword(
      {required String userId, required String password}) {
    return Future.value();
  }

  @override
  void updateUserLocal(User user) {
    return;
  }

  @override
  Future<void> updateUsername(
      {required String userId, required String username}) {
    return Future.value();
  }

  // @override
  // Future<void> login(String email, String password) async {
  //   state = UserState(
  //     data: User(
  //       id: 'userId',
  //       username: 'username',
  //       email: email,
  //       password: password,
  //       stripeCustomerId: 'stripeId',
  //       createdAt: '11111',
  //       updatedAt: '11111',
  //     ),
  //   );
  // }

  // @override
  // Future<void> logout() async {
  //   state = UserState();
  // }
}
