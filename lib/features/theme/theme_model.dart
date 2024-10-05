enum ThemeModeType { system, light, dark }

class ThemeModeModel {
  ThemeModeModel({required this.mode});
  final ThemeModeType mode;

  // Add convenience methods if necessary
  static ThemeModeType fromString(String mode) {
    switch (mode.toLowerCase()) {
      case 'light':
        return ThemeModeType.light;
      case 'dark':
        return ThemeModeType.dark;
      default:
        return ThemeModeType.system;
    }
  }
}
