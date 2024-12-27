import 'package:riverpod/riverpod.dart';

import '../services/hive_services.dart';

/// Provider for the username
final usernameProvider = Provider<String?>((ref) {
  return HiveService.getName();
});

/// Provider for the user's birthdate
final birthdateProvider = Provider<DateTime?>((ref) {
  return HiveService.getBirthdate();
});

/// Provider for the app theme (dark mode or light mode)
final appThemeProvider = Provider<String>((ref) {
  return HiveService.getAppTheme();
});

/// Provider for notifications (enabled or disabled)
final notificationsProvider = Provider<bool>((ref) {
  return HiveService.getNotifications() ?? true;
});
