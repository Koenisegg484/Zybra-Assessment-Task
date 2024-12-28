import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_manager/widgets/tasks_list_entry.dart';
import '../providers/tasks_list_providers.dart';

class TaskList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksNotifierProvider); // Listen to tasksNotifierProvider

    return tasks.isEmpty
        ? const Center(child: Text('No tasks available'))
        : ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Dismissible(
            key: Key(task.id.toString()), // Ensure task.id is not null
            direction: DismissDirection.endToStart,
            background: Container(
              color: const Color(0xfff57c7c),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: AlignmentDirectional.centerEnd,
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete Task'),
                    content: const Text(
                        'Are you sure you want to delete this task?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop(true),
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            onDismissed: (direction) async {
              await ref
                  .read(tasksNotifierProvider.notifier)
                  .deleteTaskProvider(task.id!);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${task.title} deleted')),
              );
            },
            child: TasksListEntry(task: task),
          );
        },
      ),
    );
  }
}





// class TaskList extends ConsumerWidget {
//   final List<Task> tasks;
//
//   TaskList({required this.tasks});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return ClipRRect(
//       borderRadius: const BorderRadius.all(Radius.circular(30)),
//       child: ListView.builder(
//         itemCount: tasks.length,
//         itemBuilder: (context, index) {
//           final task = tasks[index];
//           return Dismissible(
//             key: Key(task.id.toString()),
//             // Ensure task.id is not null
//             direction: DismissDirection.endToStart,
//             background: Container(
//               color: const Color(0xfff57c7c),
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               alignment: AlignmentDirectional.centerEnd,
//               child: const Icon(
//                 Icons.delete,
//                 color: Colors.white,
//               ),
//             ),
//             confirmDismiss: (direction) async {
//               return await showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Delete Task'),
//                     content: Text('Are you sure you want to delete this task?'),
//                     actions: <Widget>[
//                       TextButton(
//                         onPressed: () => Navigator.of(context).pop(false),
//                         child: Text('Cancel'),
//                       ),
//                       TextButton(
//                         onPressed: () => Navigator.of(context).pop(true),
//                         child: Text('Delete'),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             },
//             onDismissed: (direction) async {
//               ref.read(deleteTaskProvider(task.id!).future).then((result) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('${task.title} deleted')),
//                 );
//                 // Remove the task from the list
//                 tasks.removeAt(index);
//               }).catchError((error) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Failed to delete task')),
//                 );
//               });
//             },
//             child: TasksListEntry(task: task),
//           );
//         },
//       ),
//     );
//   }
// }