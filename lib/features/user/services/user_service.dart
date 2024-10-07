import 'package:rlv2_flutter/features/user/models/create_user_model.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/features/user/repositories/user_repository.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class UserService {
  UserService({
    required this.userRepository,
  });

  final UserRepository userRepository;

  Future<User> fetchUser(String userId) async {
    try {
      final user = await userRepository.fetchUser(userId);
      return user;
    } catch (e) {
      handleError(e, 'Failed to fetch user');
      rethrow;
    }
  }

  Future<User> createUser({
    required CreateUser data,
  }) async {
    try {
      final response = await userRepository.createUser(data: data);
      return response;
    } catch (e) {
      handleError(e, 'Failed to create user');
      rethrow;
    }
  }

  Future<User> updateUser({
    required String userId,
    required CreateUser data,
  }) async {
    try {
      final response = await userRepository.updateUser(
        userId: userId,
        data: data,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update user');
      rethrow;
    }
  }

  Future<User> updateEmail({
    required String userId,
    required String email,
  }) async {
    try {
      final response =
          await userRepository.updateEmail(userId: userId, email: email);
      return response;
    } catch (e) {
      handleError(e, 'Failed to update email');
      rethrow;
    }
  }

  Future<User> deleteUser(String userId) async {
    try {
      final response = await userRepository.deleteUser(userId);
      return response;
    } catch (e) {
      handleError(e, 'Failed to delete user');
      rethrow;
    }
  }

  Future<User> updateUsername({
    required String userId,
    required String username,
  }) async {
    try {
      final response = await userRepository.updateUsername(
        userId: userId,
        username: username,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update username');
      rethrow;
    }
  }

  Future<User> updatePassword({
    required String userId,
    required String password,
  }) async {
    try {
      final response = await userRepository.updatePassword(
        userId: userId,
        password: password,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update password');
      rethrow;
    }
  }
}
