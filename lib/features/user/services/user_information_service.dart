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
}
