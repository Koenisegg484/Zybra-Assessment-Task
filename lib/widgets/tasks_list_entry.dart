import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/screens/update_task_screen.dart';
import '../models/tasks_model.dart';
import '../providers/tasks_list_providers.dart';

class TasksListEntry extends ConsumerWidget {
  const TasksListEntry({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTaskScreen(task: task)));
      },

      isThreeLine: true,
      subtitle: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(width: 1),
          color: const Color(0xffffe5e5),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Chip(
                  label: Text(
                    "${task.priority}",
                    style: const TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w600),
                  ),
                  backgroundColor: _getBackgroundColor(task.priority!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                const Spacer(),
                StatusButton(
                  isCompleted: task.status,
                  onToggle: () {
                    ref.read(tasksNotifierProvider.notifier).updateTaskStatus(task.id!, !task.status);
                  },
                ),
              ],
            ),
            Text(
              task.title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 25,
                decoration:
                task.status ? TextDecoration.lineThrough : TextDecoration.none,
              ),
              textAlign: TextAlign.start,
            ),
            Chip(
              label: Text(
                task.tags ?? '',
                style: const TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              backgroundColor: const Color(0xffb2fa8d),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  color: Colors.grey,
                  size: 25,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Date",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    Text(
                      formatDate(task.startDate!) ?? 'N/A',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Due Date",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    Text(
                      formatDate(task.dueDate!) ?? 'N/A',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Time",
                      style: TextStyle(
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    Text(
                      task.startTime ?? 'N/A',
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget cardTile(WidgetRef ref) {
  //   return
  // }

  Color _getBackgroundColor(String text) {
    switch (text.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.redAccent;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.yellow;
      default:
        return Colors.grey;
    }
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
}

class StatusButton extends StatelessWidget {
  final bool isCompleted;
  final VoidCallback onToggle;

  const StatusButton({
    super.key,
    required this.isCompleted,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onToggle,
      style: ElevatedButton.styleFrom(
        backgroundColor: isCompleted ? Colors.green : Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: Text(
        isCompleted ? 'COMPLETED' : 'PENDING',
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}






// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../models/tasks_model.dart';
//
// class TasksListEntry extends StatelessWidget {
//   const TasksListEntry({
//     super.key,
//     required this.task,
//   });
//
//   final Task task;
//
//   @override
//   Widget build(BuildContext context) {
//     return cardTile();
//   }
//
//   Widget cardTile() {
//     return ListTile(
//       contentPadding: const EdgeInsets.all(0),
//       onTap: (){
//         //   TODO: Handle ontap
//       },
//       isThreeLine: true,
//       subtitle: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(30)),
//             border: Border.all(width: 1),
//             color: Color(0xffffe5e5)
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//         width: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Chip(label: Text("${task.priority}",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),),
//                   backgroundColor: _getBackgroundColor(task.priority!),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
//                 ),
//                 Spacer(),
//                 StatusButton(isCompleted: task.status,)
//               ],
//             ),
//             Text(task.title, style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 25),textAlign: TextAlign.start,),
//             Chip(label: Text("${task.tags}",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),),
//               backgroundColor: Color(0xffb2fa8d),
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50),),
//             ),
//             SizedBox(height: 12,),
//             Row(
//               children: [
//                 Icon(Icons.calendar_month_rounded, color: Colors.grey, size: 25,),
//                 SizedBox(width: 12,),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Start Date", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500, fontSize: 15),textAlign: TextAlign.start, ),
//                     Text("${formatDate(task.startDate!) ?? 'N/A'}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),)
//                   ],
//                 ),
//                 SizedBox(width: 12,),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Due Date", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500, fontSize: 15),textAlign: TextAlign.start, ),
//                     Text("${formatDate(task.dueDate!) ?? 'N/A'}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),)
//                   ],
//                 ),
//                 Spacer(),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text("Start Time", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w500, fontSize: 15),textAlign: TextAlign.start, ),
//                     Text("${task.startTime ?? 'N/A'}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),)
//                   ],
//                 ),
//
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color _getBackgroundColor(String text) {
//     switch (text.toLowerCase()) {
//       case 'critical':
//         return Colors.red;
//       case 'high':
//         return Colors.redAccent;
//       case 'medium':
//         return Colors.orange;
//       case 'low':
//         return Colors.yellow;
//       default:
//         return Colors.grey;
//     }
//   }
//
//   String formatDate(DateTime date){
//     return DateFormat('dd MMM yyyy').format(date);
//   }
// }
//
// class StatusButton extends StatefulWidget {
//
//   final bool isCompleted;
//
//   const StatusButton({super.key, required this.isCompleted});
//   @override
//   _StatusButtonState createState() => _StatusButtonState();
// }
//
// class _StatusButtonState extends State<StatusButton> {
//   late bool isCompleted;
//   @override
//   void initState() {
//     isCompleted = widget.isCompleted;
//     super.initState();
//   }
//
//   void _toggleButton() {
//     setState(() {
//       isCompleted = !isCompleted;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: _toggleButton,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: isCompleted ? Colors.green : Colors.red,
//         padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(100),
//         ),
//       ),
//       child: Text(
//         isCompleted ? 'COMPLETED' : 'PENDING',
//         style: TextStyle(
//           fontSize: 15,
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }