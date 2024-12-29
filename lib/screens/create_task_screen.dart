import 'package:flutter/material.dart';
import 'package:task_manager/config/themes/constants.dart';
import 'package:task_manager/screens/task_form.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

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
        padding: miniPadding,
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
