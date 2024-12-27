import 'package:flutter/material.dart';
import 'package:task_manager/screens/task_form.dart';

import '../models/tasks_model.dart';

class CreateTaskScreen extends StatelessWidget {
  CreateTaskScreen({super.key});

  final GlobalKey<FormState> createTaskFormKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController customTagController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();

  DateTime? _startDate;
  DateTime? _dueDate;
  int? selectedPriorityIndex;
  int? selectedTagsIndex;
  bool showCustomField = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color(0xfff5d6fc),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TaskFormWidget(onSubmit: (value){}),
            ],
          ),
        ),
      ),
    );
  }

}
