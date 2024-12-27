import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_manager/screens/create_task_screen.dart';
import 'package:task_manager/services/database_service.dart';
import 'package:task_manager/services/hive_services.dart';
import 'package:task_manager/widgets/no_tasks_yet.dart';
import '../models/tasks_model.dart';
import '../widgets/sort_chips.dart';

class TodoHomeScreen extends StatefulWidget {
  TodoHomeScreen({super.key});

  @override
  _TodoHomeScreenState createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  final greetings = "Hello";
  final username = HiveService.getName();

  Future<List<Task>>? tasksList;

  @override
  void initState() {
    super.initState();
    tasksList = DatabaseHelper.instance.getTasks();
  }

  void _refreshTasks() {
    setState(() {
      tasksList = DatabaseHelper.instance.getTasks(); // Re-fetch tasks
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/images/happyface.png", fit: BoxFit.contain,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greetings,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Text(
                  "$username",
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                )
              ],
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                // Wait for task creation, then refresh
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateTaskScreen()));
                _refreshTasks(); // Refresh task list after creating new task
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                elevation: 10,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    side: BorderSide(color: Colors.black, width: 1)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(color: Colors.black87),
                      child: const Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Create new Task",
                    style: TextStyle(
                        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: [
            const Row(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // TODO: Create Sorting techniques
                      SortChip(title: "All", nums: 12),
                      SortChip(title: "Completed", nums: 12),
                      SortChip(title: "Pending", nums: 9),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Use FutureBuilder to load tasks from the database asynchronously
            Expanded(
              child: FutureBuilder<List<Task>>(
                future: tasksList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: NoTasks());
                  } else {
                    final tasks = snapshot.data!;

                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];

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
                            //   TODO
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}