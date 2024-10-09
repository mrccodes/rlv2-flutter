import 'package:flutter/material.dart';
import 'package:rlv2_flutter/features/user/models/user_information_model.dart';
import 'package:rlv2_flutter/features/user/models/user_model.dart';
import 'package:rlv2_flutter/features/user/models/user_settings_model.dart';

User testUser = User(
  id: 'userId',
  username: 'username',
  email: 'email',
  password: 'password',
  stripeCustomerId: 'stripeId',
  createdAt: '11111',
  updatedAt: '11111',
);

UserSettings testUserSettings = UserSettings(
  userId: 'test-id',
  notifications: false,
  pushNotifications: false,
  emailNotifications: false,
  preferredMode: ThemeMode.light.name,
  newsletter: false,
  dataSharingConsent: false,
  showTipsAndTricks: false,
  createdAt: '11111',
  updatedAt: '111111',
);

UserInformation testUserInformation = UserInformation(
  userId: 'test-id',
  createdAt: '1111111',
  updatedAt: '111111',
  firstName: 'matt',
  lastName: 'matt',
  image: null,
  bio: 'Test bio',
);
