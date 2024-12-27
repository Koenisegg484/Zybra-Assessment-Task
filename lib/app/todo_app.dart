import 'package:flutter/material.dart';
import 'package:task_manager/screens/preferences_screen.dart';
import 'package:task_manager/services/hive_services.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/tell_name_screen.dart';

import '../config/themes/themes.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: HiveService.getName() == null ? TellNameScreen() : PreferencesScreen(),
    );
  }
}