import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/user_preferences_providers.dart';
import '../services/hive_services.dart';

class ThemeOptions extends ConsumerWidget {
  const ThemeOptions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(appThemeProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildThemeOption(
                context,
                label: "Light",
                mode: "light",
                icon: Icons.wb_sunny,
                currentMode: themeMode,
                ref: ref,
              ),
              _buildThemeOption(
                context,
                label: "Dark",
                mode: "dark",
                icon: Icons.nights_stay,
                currentMode: themeMode,
                ref: ref,
              ),
              _buildThemeOption(
                context,
                label: "System",
                mode: "system",
                icon: Icons.settings,
                currentMode: themeMode,
                ref: ref,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context,
      {required String label,
        required String mode,
        required IconData icon,
        required String currentMode,
        required WidgetRef ref})
  {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            HiveService.saveAppTheme(mode);
            ref.invalidate(appThemeProvider);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              size: 50,
              color: mode == currentMode ? Colors.blue : Colors.grey.shade700,
            ),
          ),
        ),
        Radio<String>(
          value: mode,
          groupValue: currentMode,
          onChanged: (String? value) {
            HiveService.saveAppTheme(value);
            ref.invalidate(appThemeProvider);
          },
        ),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
