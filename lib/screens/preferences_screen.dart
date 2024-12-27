import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/services/hive_services.dart';
import 'package:task_manager/widgets/theme_options.dart';
import 'package:task_manager/widgets/toggle_button.dart';

import '../providers/user_preferences_providers.dart';


class PreferencesScreen extends ConsumerWidget {
  PreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(usernameProvider);
    final birthdate = ref.watch(birthdateProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Text(
                  "Preferences",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                )
              ],
            )
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/happyface.png",
                        width: 70,
                        height: 70,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username ?? "--",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            birthdate != null
                                ? "${birthdate.day}/${birthdate.month}/${birthdate.year}"
                                : "--",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ],
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade500,
                      padding: const EdgeInsets.all(5),
                      iconColor: Colors.white,
                      shape: const CircleBorder(),
                    ),
                    child: const Icon(Icons.chevron_right_rounded),
                  )
                ],
              ),
            ),
            const Divider(),
            const Text("Preferences",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 26)),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 12),
                const Text("Notifications",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 22)),
                const Spacer(),
                NotificationToggleButton()
              ],
            ),
            const Divider(),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.light_mode_rounded,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 12),
                    const Text("App Theme",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 22)),
                  ],
                ),
                ThemeOptions()
              ],
            ),
          ],
        ),
      ),
    );
  }
}
