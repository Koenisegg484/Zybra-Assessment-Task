import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_manager/app/todo_app.dart';
import 'package:task_manager/services/hive_services.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // Initialising Hive
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  await Hive.openBox("TaskApp");

  // App Runs
  runApp(const ProviderScope( child: TodoApp(),));
}