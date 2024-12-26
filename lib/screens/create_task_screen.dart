import 'package:flutter/material.dart';
import 'package:task_manager/screens/task_form.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xfff5d6fc),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TaskFormWidget(onSubmit: (value){}),
            Center(
                child: ElevatedButton(
                    onPressed: () {

                    },
                    child: const Text("Be Productive",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w600))))
          ],
        ),
      ),
    );
  }
}
