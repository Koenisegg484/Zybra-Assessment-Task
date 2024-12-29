import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/config/themes/animated_page_router.dart';
import 'package:task_manager/config/themes/constants.dart';
import 'package:task_manager/screens/update_task_screen.dart';

import '../models/tasks_model.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task currentTask;

  TaskDetailsScreen({super.key, required this.currentTask});

  final InputDecoration inputDecoration = InputDecoration(
    hintStyle: TextStyle(
        fontSize: 22, color: Colors.grey.shade400, fontWeight: FontWeight.w600),
    filled: true,
    fillColor: Colors.grey.shade50,
    contentPadding:
        const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none,
    ),
  );

  Widget tagHeading(
      {required Color color, required Icon icon, required String title}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.black, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: icon,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w400, fontSize: 25, color: Colors.black),
        )
      ],
    );
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  Widget textBox(String inputText) {
    return Container(
      padding: miniPadding,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        inputText,
        style: TextStyle(
          fontSize: 25,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final task = currentTask;
          
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Your Task",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MagnificationPageRoute(page: UpdateTaskScreen(task: task)),
                            );
                          },
                          icon: const Icon(
                            Icons.edit_note_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        tagHeading(
                          color: const Color(0xfffa60f6),
                          icon: const Icon(FontAwesomeIcons.flag, size: 15, color: Colors.black),
                          title: "Title",
                        ),
                        const SizedBox(height: 16),
                        textBox(task.title),
                        const SizedBox(height: 16),
                        tagHeading(
                          color: const Color(0xff6ffa60),
                          icon: const Icon(FontAwesomeIcons.noteSticky, size: 15, color: Colors.black),
                          title: "Description",
                        ),
                        const SizedBox(height: 16),
                        textBox(task.description),
                        const SizedBox(height: 16),
                        tagHeading(
                          color: const Color(0xff606dfa),
                          icon: const Icon(FontAwesomeIcons.calendarDays, size: 15, color: Colors.black),
                          title: "Duration",
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: AbsorbPointer(
                                child: textBox(formatDate(task.startDate!)),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: AbsorbPointer(
                                child: textBox(formatDate(task.dueDate!)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (task.priority != null) ...[
                          tagHeading(
                            color: const Color(0xfffa6363),
                            icon: const Icon(FontAwesomeIcons.exclamation, size: 15, color: Colors.black),
                            title: "Priority",
                          ),
                          const SizedBox(height: 16),
                          textBox(task.priority!),
                          const SizedBox(height: 16),
                        ],
                        if (task.tags != null && task.tags!.isNotEmpty) ...[
                          tagHeading(
                            color: const Color(0xfffadb60),
                            icon: const Icon(FontAwesomeIcons.arrowPointer, size: 15, color: Colors.black),
                            title: "Tags",
                          ),
                          const SizedBox(height: 16),
                          textBox(task.tags!), // Assuming tags is a List<String>
                          const SizedBox(height: 16),
                        ],
                        tagHeading(
                          color: const Color(0xffaffffc),
                          icon: const Icon(FontAwesomeIcons.clock, size: 15, color: Colors.black),
                          title: "Start Time",
                        ),
                        const SizedBox(height: 16),
                        textBox(task.startTime ?? "Not set"),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),

    );
  }
}