class UserSettings {
  UserSettings({
    required this.userId,
    required this.notifications,
    required this.pushNotifications,
    required this.emailNotifications,
    required this.newsletter,
    required this.dataSharingConsent,
    required this.showTipsAndTricks,
    required this.createdAt,
    required this.updatedAt,
    this.preferredMode,
    this.preferredVolumeUnit,
    this.preferredMassUnit,
    this.preferredLengthUnit,
    this.preferredTemperatureUnit,
  });

  // Factory method to create a UserSettings from a JSON object
  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      userId: json['userId'] as String,
      preferredMode: json['preferredMode'] as String?,
      preferredVolumeUnit: json['preferredVolumeUnit'] as String?,
      preferredMassUnit: json['preferredMassUnit'] as String?,
      preferredLengthUnit: json['preferredLengthUnit'] as String?,
      preferredTemperatureUnit: json['preferredTemperatureUnit'] as String?,
      notifications: json['notifications'] as bool,
      pushNotifications: json['pushNotifications'] as bool,
      emailNotifications: json['emailNotifications'] as bool,
      newsletter: json['newsletter'] as bool,
      dataSharingConsent: json['dataSharingConsent'] as bool,
      showTipsAndTricks: json['showTipsAndTricks'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
  final String userId;
  final String? preferredMode;
  final String? preferredVolumeUnit;
  final String? preferredMassUnit;
  final String? preferredLengthUnit;
  final String? preferredTemperatureUnit;
  final bool notifications;
  final bool pushNotifications;
  final bool emailNotifications;
  final bool newsletter;
  final bool dataSharingConsent;
  final bool showTipsAndTricks;
  final String createdAt;
  final String updatedAt;

  // Method to convert a UserSettings object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'preferredMode': preferredMode,
      'preferredVolumeUnit': preferredVolumeUnit,
      'preferredMassUnit': preferredMassUnit,
      'preferredLengthUnit': preferredLengthUnit,
      'preferredTemperatureUnit': preferredTemperatureUnit,
      'notifications': notifications,
      'pushNotifications': pushNotifications,
      'emailNotifications': emailNotifications,
      'newsletter': newsletter,
      'dataSharingConsent': dataSharingConsent,
      'showTipsAndTricks': showTipsAndTricks,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  @override
  String toString() {
    return 'UserSettings{userId: $userId, preferredMode: $preferredMode, preferredVolumeUnit: $preferredVolumeUnit, preferredMassUnit: $preferredMassUnit, preferredLengthUnit: $preferredLengthUnit, preferredTemperatureUnit: $preferredTemperatureUnit, notifications: $notifications, pushNotifications: $pushNotifications, emailNotifications: $emailNotifications, newsletter: $newsletter, dataSharingConsent: $dataSharingConsent, showTipsAndTricks: $showTipsAndTricks, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
