import 'package:flutter/material.dart';
import 'package:task_manager/screens/update_task_form.dart';

import '../models/tasks_model.dart';

class UpdateTaskScreen extends StatelessWidget {
  final Task task;

  const UpdateTaskScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UpdateTaskFormWidget(
                existingTask: task,
                onUpdate: (updatedTask) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task updated successfully!')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
