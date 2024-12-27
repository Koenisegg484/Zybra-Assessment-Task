import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_preferences_providers.dart';
import '../services/hive_services.dart';


class NotificationToggleButton extends ConsumerWidget {
  const NotificationToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsEnabled = ref.watch(notificationsProvider);

    return ElevatedButton(
      onPressed: () {
        final newStatus = !(notificationsEnabled ?? true);
        HiveService.saveNotifications(newStatus);
        ref.invalidate(notificationsProvider);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: notificationsEnabled == true ? Colors.green : Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            notificationsEnabled == true ? Icons.notifications_active : Icons.notifications_off,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            notificationsEnabled == true ? 'On' : 'Off',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
