import 'package:flutter/material.dart';


class ThemeOptions extends StatefulWidget {
  @override
  _ThemeOptionsState createState() => _ThemeOptionsState();
}

class _ThemeOptionsState extends State<ThemeOptions> {
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildThemeOption(
                label: "Light",
                themeMode: ThemeMode.light,
                icon: Icons.wb_sunny,
              ),
              _buildThemeOption(
                label: "Dark",
                themeMode: ThemeMode.dark,
                icon: Icons.nights_stay,
              ),
              _buildThemeOption(
                label: "System",
                themeMode: ThemeMode.system,
                icon: Icons.settings,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption({required String label, required ThemeMode themeMode, required IconData icon}) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _themeMode = themeMode;
            });
          },
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Icon(icon, size: 50, color: Colors.grey.shade700),
          ),
        ),
        Radio<ThemeMode>(
          value: themeMode,
          groupValue: _themeMode,
          onChanged: (ThemeMode? value) {
            setState(() {
              _themeMode = value!;
            });
          },
        ),
        Text(label, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
