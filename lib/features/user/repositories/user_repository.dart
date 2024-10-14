import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/user/models/create_user_model.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class UserRepository {
  UserRepository({
    required this.apiService,
  });

  final ApiService apiService;
  final endpoint = '/users';

  Future<User> fetchUser(String userId) async {
    try {
      final response = await apiService.getRequest<User>(
        '$endpoint/$userId',
        (val) => User.fromJson(val as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch user');
      rethrow;
    }
  }

  Future<User> createUser({
    required CreateUser data,
  }) async {
    try {
      final response = await apiService.postRequest<User>(
        endpoint,
        data.toJson(),
        (val) => User.fromJson(val as Map<String, dynamic>),
      );
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
      final response = await apiService.putRequest<User>(
        '$endpoint/$userId',
        data.toJson(),
        (val) => User.fromJson(val as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update user information data');
      rethrow;
    }
  }

  Future<User> updateEmail({
    required String userId,
    required String email,
  }) async {
    try {
      final response = await apiService.patchRequest<User>(
        '$endpoint/$userId',
        {'email': email},
        (val) => User.fromJson(val as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update user email');
      rethrow;
    }
  }

  Future<User> updateUsername({
    required String userId,
    required String username,
  }) async {
    try {
      final response = await apiService.patchRequest<User>(
        '$endpoint/$userId',
        {'username': username},
        (val) => User.fromJson(val as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update user username');
      rethrow;
    }
  }

  Future<User> updatePassword({
    required String userId,
    required String password,
  }) async {
    try {
      final response = await apiService.patchRequest<User>(
        '$endpoint/$userId',
        {'password': password},
        (val) => User.fromJson(val as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update user password');
      rethrow;
    }
  }

  Future<User> deleteUser(String userId) async {
    try {
      final response = await apiService.deleteRequest<User>(
        '$endpoint/$userId',
        (val) => User.fromJson(val as Map<String, dynamic>),
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to delete user');
      rethrow;
    }
  }
}
