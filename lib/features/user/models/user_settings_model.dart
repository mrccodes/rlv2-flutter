class UserSettings {
  UserSettings({
    required this.userId,
    required this.preferredMode,
    required this.preferredVolumeUnit,
    required this.preferredMassUnit,
    required this.preferredLengthUnit,
    required this.preferredTemperatureUnit,
    required this.notifications,
    required this.pushNotifications,
    required this.emailNotifications,
    required this.newsletter,
    required this.dataSharingConsent,
    required this.showTipsAndTricks,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create a UserSettings from a JSON object
  factory UserSettings.fromJson(Map<String, String> json) {
    return UserSettings(
      userId: json['userId']!,
      preferredMode: json['preferredMode']!,
      preferredVolumeUnit: json['preferredVolumeUnit']!,
      preferredMassUnit: json['preferredMassUnit']!,
      preferredLengthUnit: json['preferredLengthUnit']!,
      preferredTemperatureUnit: json['preferredTemperatureUnit']!,
      notifications: json['notifications']!,
      pushNotifications: json['pushNotifications']!,
      emailNotifications: json['emailNotifications']!,
      newsletter: json['newsletter']!,
      dataSharingConsent: json['dataSharingConsent']!,
      showTipsAndTricks: json['showTipsAndTricks']!,
      createdAt: json['createdAt']!,
      updatedAt: json['updatedAt']!,
    );
  }
  final String userId;
  final String preferredMode;
  final String preferredVolumeUnit;
  final String preferredMassUnit;
  final String preferredLengthUnit;
  final String preferredTemperatureUnit;
  final String notifications;
  final String pushNotifications;
  final String emailNotifications;
  final String newsletter;
  final String dataSharingConsent;
  final String showTipsAndTricks;
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
}
