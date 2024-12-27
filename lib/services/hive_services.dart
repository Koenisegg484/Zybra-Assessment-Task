import 'package:hive/hive.dart';

class HiveService {
  static final _box = Hive.box("TaskApp");

  // Save and Get Name
  static void saveName(String name) {
    name = name.trim();
    name = name[0].toUpperCase() + name.substring(1);
    _box.put("username", name);
  }

  static String? getName() {
    return _box.get("username");
  }

  // Save and Get Birthdate
  static void saveBirthdate(DateTime birthdate) {
    _box.put("birthdate", birthdate.toIso8601String());
  }

  static DateTime? getBirthdate() {
    final birthdateString = _box.get("birthdate");
    if (birthdateString != null) {
      return DateTime.parse(birthdateString);
    }
    return null;
  }

  // Save and Get App Theme (system for system default, light for light theme, dark for dark theme)
  static void saveAppTheme(String? mode) {
    mode ??= "system";
    _box.put("appTheme", mode);
  }

  static String getAppTheme() {
    return _box.get("appTheme");
  }

  // Save and Get Notifications Preference (true for enabled, false for disabled)
  static void saveNotifications(bool notificationsEnabled) {
    _box.put("notifications", notificationsEnabled);
  }

  static bool? getNotifications() {
    return _box.get("notifications");
  }
}