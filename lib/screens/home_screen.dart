import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/config/themes/constants.dart';
import 'package:task_manager/screens/task_details_screen.dart';
import 'package:task_manager/widgets/my_custom_app_bar.dart';
import 'package:task_manager/widgets/no_tasks_yet.dart';
import 'package:task_manager/widgets/tasks_list.dart';
import '../models/tasks_model.dart';
import '../providers/tasks_list_providers.dart';

class TodoHomeScreen extends ConsumerWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksList = ref.watch(tasksListProvider);
    final selectedTask = ref.watch(selectedTaskProvider);

    return Scaffold(
      appBar: const MyCustomAppBar(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isTablet = constraints.maxWidth >= 600;

          return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: tasksList.when(
              data: (tasks) {
                if (tasks.isEmpty) {
                  return const Center(child: NoTasks());
                }

                return isTablet
                    ? Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TaskList(
                        onTaskSelected: (task) {
                          ref.read(selectedTaskProvider.notifier).state = task as Task?;
                        },
                      ),
                    ),
                    miniSpacing,
                    Container(
                      color: Colors.black87,
                      width: 1,
                    ),
                    miniSpacing,
                    Expanded(
                      flex: 3,
                      child: selectedTask == null
                          ? const Center(child: Text('Select a task'))
                          : TaskDetailsScreen(currentTask: selectedTask),
                    ),
                  ],
                )
                    : TaskList(
                  onTaskSelected: (task) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsScreen(currentTask: task),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          );
        },
      ),
    );
  }

}


//             // TODO: Make Filters
//             // const Row(
//             //   children: [
//             //     SingleChildScrollView(
//             //       scrollDirection: Axis.horizontal,
//             //       child: Row(
//             //         mainAxisAlignment: MainAxisAlignment.spaceAround,
//             //         children: [
//             //           SortChip(title: "All", nums: 12),
//             //           SortChip(title: "Completed", nums: 12),
//             //           SortChip(title: "Pending", nums: 9),
//             //         ],
//             //       ),
//             //     ),
//             //   ],
//             // ),