import 'package:rlv2_flutter/core/services/api_service.dart';
import 'package:rlv2_flutter/features/user/models/user_information_model.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class UserInformationRepository {
  UserInformationRepository({
    required this.apiService,
  });

  final ApiService apiService;

  static String makePath(String userId) {
    return '/users/$userId/information';
  }

  Future<UserInformation> updateUserInformation({
    required String userId,
    required UserInformation data,
  }) async {
    try {
      final response = await apiService.patchRequest(
        makePath(userId),
        data.toJson(),
        UserInformation.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to update user information data');
      rethrow;
    }
  }

  Future<UserInformation> getUserInformation(String userId) async {
    try {
      final response = await apiService.getRequest<UserInformation>(
        makePath(userId),
        UserInformation.fromJson,
      );

      return response;
    } catch (e) {
      handleError(e, 'Failed to fetch user information data');
      rethrow;
    }
  }

  Future<UserInformation> deleteUserInformation(String userId) async {
    try {
      final response = await apiService.deleteRequest<UserInformation>(
        makePath(userId),
        UserInformation.fromJson,
      );
      return response;
    } catch (e) {
      handleError(e, 'Failed to delete user information data');
      rethrow;
    }
  }

  Future<void> patchUserInformation(
    String userId,
    Map<String, dynamic> data,
  ) async {
    try {
      await apiService.patchRequest(
        makePath(userId),
        data,
        UserInformation.fromJson,
      );
    } catch (e) {
      handleError(e, 'Failed to patch user information data');
      rethrow;
    }
  }
}
