import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tasks_model.dart';
import '../providers/tasks_list_providers.dart';

class TaskList extends ConsumerWidget {
  final List<Task> tasks;

  TaskList({required this.tasks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClipRRect(
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
                    title: Text('Delete Task'),
                    content: Text('Are you sure you want to delete this task?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            onDismissed: (direction) async {
              ref.read(deleteTaskProvider(task.id!).future).then((result) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${task.title} deleted')),
                );
                // Remove the task from the list
                tasks.removeAt(index);
              }).catchError((error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to delete task')),
                );
              });
            },
            child: TasksListEntry(task: task),
          );
        },
      ),
    );
  }
}

class TasksListEntry extends StatelessWidget {
  const TasksListEntry({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          task.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${task.description}'),
            Text('Priority: ${task.priority ?? 'N/A'}'),
            Text('Tags: ${task.tags ?? 'None'}'),
            Text('Start Date: ${task.startDate?.toLocal().toString() ?? 'N/A'}'),
            Text('Due Date: ${task.dueDate?.toLocal().toString() ?? 'N/A'}'),
            Text('Start Time: ${task.startTime ?? 'N/A'}'),
            Text('Status: ${task.status ? 'Completed' : 'Pending'}'),
          ],
        ),
        isThreeLine: true,
        onTap: () {
          // TODO: Handle task tap
        },
      ),
    );
  }
}
