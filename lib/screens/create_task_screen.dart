import 'package:flutter/material.dart';
import 'package:task_manager/screens/task_form.dart';

import '../models/tasks_model.dart';

class CreateTaskScreen extends StatelessWidget {
  CreateTaskScreen({super.key});

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
              TaskFormWidget(onSubmit: (value){}),
            ],
          ),
        ),
      ),
    );
  }

}
