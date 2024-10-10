import 'package:rlv2_flutter/features/user/models/create_user_information_model.dart';
import 'package:rlv2_flutter/features/user/models/user_information_model.dart';
import 'package:rlv2_flutter/features/user/repositories/user_information_repository.dart';
import 'package:rlv2_flutter/utils/handle_error.dart';

class UserInformationService {
  UserInformationService({
    required this.userInformationRepository,
  });

  final UserInformationRepository userInformationRepository;

  Future<UserInformation> getUserInformation(String userId) async {
    try {
      final userInformation =
          await userInformationRepository.getUserInformation(userId);
      return userInformation;
    } catch (e) {
      handleError(e, 'Error fetching user information');
      rethrow;
    }
  }

  Future<UserInformation> createUserInformation(
      CreateUserInformation userInformation) async {
    try {
      final newUserInformation = await userInformationRepository
          .createUserInformation(data: userInformation);
      return newUserInformation;
    } catch (e) {
      handleError(e, 'Error creating user information');
      rethrow;
    }
  }
}
