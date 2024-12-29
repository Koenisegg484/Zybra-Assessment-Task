import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/tasks_model.dart';
import '../services/database_service.dart';
import 'package:flutter/material.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  Future<void> loadTasks() async {
    state = await DatabaseHelper.instance.getTasks();
  }

  Future<void> updateTask(Task task) async {
    await DatabaseHelper.instance.updateTask(task);
    state = [
      for (final t in state)
        if (t.id == task.id) task else t
    ];
  }

  Future<void> updateTaskStatus(int id, bool newStatus) async {
    await DatabaseHelper.instance.updateTaskStatus(id, newStatus);
    state = [
      for (final task in state)
        if (task.id == id) task.copyWith(status: newStatus) else task
    ];
  }

  final deleteTaskProvider = FutureProvider.family<int, int>((ref, id) async {
    return DatabaseHelper.instance.deleteTask(id);
  });

  Task? getTaskById(int id) {
    return state.firstWhere((task) => task.id == id);
  }

}

final tasksNotifierProvider =
    StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  final notifier = TasksNotifier();
  notifier.loadTasks();
  return notifier;
});

final tasksListProvider = FutureProvider<List<Task>>((ref) async {
  return await DatabaseHelper.instance.getTasks();
});

final deleteTaskProvider = FutureProvider.family<int, int>((ref, id) async {
  return DatabaseHelper.instance.deleteTask(id);
});

final selectedTaskProvider = StateProvider<Task?>((ref) => null);



// Future<void> updateTaskStatus(int id, bool newStatus) async {
//   await DatabaseHelper.instance.updateTaskStatus(id, newStatus);
//   print("Status has been changed $newStatus");
//   // Fluttertoast.showToast(
//   //   msg: "Hoorayyy! A task has been completed",
//   //   toastLength: Toast.LENGTH_SHORT,
//   //   gravity: ToastGravity.BOTTOM,
//   //   backgroundColor: Colors.green,
//   //   textColor: Colors.white,
//   //   fontSize: 16.0,
//   //   webBgColor: "linear-gradient(to right, #00b09b, #96c93d)",
//   //   webPosition: "center",
//   //   // child: Row(
//   //   //   mainAxisSize: MainAxisSize.min,
//   //   //   children: [
//   //   //     Icon(Icons.check_circle, color: Colors.white),
//   //   //     SizedBox(width: 8),
//   //   //     Text(
//   //   //       'Hoorayyy! A task has been completed',
//   //   //       style: TextStyle(
//   //   //         fontSize: 16,
//   //   //         color: Colors.white,
//   //   //       ),
//   //   //     ),
//   //   //   ],
//   //   // ),
//   // );
//
//   state = [
//     for (final task in state)
//       if (task.id == id) task.copyWith(status: newStatus) else task
//   ];
// }
