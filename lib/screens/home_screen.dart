import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/screens/create_task_screen.dart';
import 'package:task_manager/services/database_service.dart';
import 'package:task_manager/services/hive_services.dart';
import 'package:task_manager/widgets/my_custom_app_bar.dart';
import 'package:task_manager/widgets/no_tasks_yet.dart';
import 'package:task_manager/widgets/tasks_list.dart';
import '../models/tasks_model.dart';
import '../providers/tasks_list_providers.dart';
import '../providers/user_preferences_providers.dart';
import '../widgets/sort_chips.dart';

class TodoHomeScreen extends ConsumerWidget {
  const TodoHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksList = ref.watch(tasksListProvider);

    return Scaffold(
      appBar: MyCustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            const Row(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SortChip(title: "All", nums: 12),
                      SortChip(title: "Completed", nums: 12),
                      SortChip(title: "Pending", nums: 9),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: tasksList.when(
                data: (tasks) {
                  if (tasks.isEmpty) {
                    return const Center(child: NoTasks());
                  }
                  return TaskList(tasks: tasks);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Error: $err')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}