import 'package:rlv2_flutter/features/organization/models/create_organization_model.dart';
import 'package:rlv2_flutter/features/user/models/create_user_information_model.dart';
import 'package:rlv2_flutter/features/user/models/create_user_model.dart';

class Register {
  Register({
    required this.user,
    required this.userInformation,
    this.organization,
  });

  factory Register.fromJson(dynamic json) {
    // ensure obj is a Map
    if (json is! Map<String, dynamic>) {
      throw Exception(
        'Invalid JSON object passed to Register.fromJson',
      );
    }
    return Register(
      user: CreateUser.fromJson(json['user'] as Map<String, dynamic>),
      userInformation: CreateUserInformation.fromJson(
        json['userInformation'] as Map<String, dynamic>,
      ),
      organization: CreateOrganization.fromJson(
        json['organization'] as Map<String, dynamic>,
      ),
    );
  }

  final CreateUser user;
  final CreateUserInformationBase userInformation;
  final CreateOrganizationBase? organization;

  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'userInformation': userInformation.toJson(),
      'organization': organization?.toJson(),
    };
  }

  @override
  String toString() {
    return 'CreateAccount{user: $user, '
        'userInformation: $userInformation, '
        'organization: $organization}';
  }
}
