import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tasks_model.dart';
import '../services/database_service.dart';

final tasksListProvider = FutureProvider<List<Task>>((ref) async {
  return await DatabaseHelper.instance.getTasks();
});

final deleteTaskProvider = FutureProvider.family<int, int>((ref, id) async {
  return DatabaseHelper.instance.deleteTask(id);
});
